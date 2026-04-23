//
//  MoviesManager.swift
//  SwiftLab2
//
//  Created by Bayoumi on 21/04/2026.
//



import UIKit

class MoviesManager {
    
    static let shared = MoviesManager()
    private init() {}
    
    private(set) var movies: [Movie] = []
    
    
    func loadMovies(completion: @escaping () -> Void) {
        
        let cached = CoreDataManager.shared.fetchMovies()
        
        if !cached.isEmpty {
            self.movies = cached
            print("Loaded \(cached.count) movies from Core Data")
            DispatchQueue.main.async { completion() }
        }
        
        guard let url = URL(string: "https://fooapi.com/api/movies") else {
            print("Invalid URL")
            if cached.isEmpty { DispatchQueue.main.async { completion() } }
            return
        }
        
        print("Fetching from API...")
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            if let error = error {
                print("API Error: \(error.localizedDescription)")
                if cached.isEmpty { DispatchQueue.main.async { completion() } }
                return
            }
            
            guard let data = data else {
                print("No data received")
                if cached.isEmpty { DispatchQueue.main.async { completion() } }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(APIResponse.self, from: data)
                print("Parsed \(response.data.count) movies from API")
                
                let apiMovies: [Movie] = response.data.map { api in
                    Movie(
                        id: Int(api.id) ?? Int.random(in: 10000...99999),
                        title: api.title,
                        subtitle: api.director,
                        description: api.plot,
                        imageName: "movie",
                        releaseYear: Int(api.year) ?? 0,
                        rating: Double(api.imdbRating) ?? 0.0,
                        genre: api.genre.components(separatedBy: ",")
                            .map { $0.trimmingCharacters(in: .whitespaces) },
                        customImage: nil,
                        posterURL: api.poster
                    )
                }
                
                let existing = CoreDataManager.shared.fetchMovies()
                let existingIds = Set(existing.map { $0.id })
                
                for movie in apiMovies where !existingIds.contains(movie.id) {
                    CoreDataManager.shared.saveMovie(movie: movie)
                }
                
                let updated = CoreDataManager.shared.fetchMovies()
                
                DispatchQueue.main.async {
                    self?.movies = updated
                    print("Total movies after merge: \(updated.count)")
                    completion()
                }
                
            } catch {
                print("JSON Parse Error: \(error)")
                if cached.isEmpty { DispatchQueue.main.async { completion() } }
            }
        }.resume()
    }
    
    
    func addMovie(movie: Movie) {
        
        var newMovie = movie
        
        if let image = movie.customImage,
           let data = image.jpegData(compressionQuality: 0.8) {
            
            let fileName = UUID().uuidString + ".jpg"
            let path = getDocumentsPath().appendingPathComponent(fileName)
            
            do {
                try data.write(to: path)
                newMovie.imagePath = fileName
            } catch {
                print("Failed to save image")
            }
        }
        
        CoreDataManager.shared.saveMovie(movie: newMovie)
        
        movies.append(newMovie)
    }
    
    
    func deleteMovie(at index: Int) {
        let movie = movies[index]
        
        CoreDataManager.shared.deleteMovie(id: movie.id)
        movies.remove(at: index)
    }
    
    
    func getMovie(at index: Int) -> Movie {
        return movies[index]
    }
    
    func moviesCount() -> Int {
        return movies.count
    }
    
    func setMovies(_ movies: [Movie]) {
        self.movies = movies
    }
    
    private func getDocumentsPath() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
