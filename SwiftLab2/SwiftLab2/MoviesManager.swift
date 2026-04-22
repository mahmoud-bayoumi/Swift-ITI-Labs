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
    
    var movies: [Movie] = []
    
    func loadMovies(completion: @escaping () -> Void) {
        
        let cached = SQLiteManager.shared.getAllMovies()
        if !cached.isEmpty {
            self.movies = cached
            print("Loaded \(cached.count) from SQLite")
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
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }
            
            guard let data = data else {
                print("No data")
                if cached.isEmpty { DispatchQueue.main.async { completion() } }
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON: \(jsonString.prefix(200))...")
            }
            
            do {
                let response = try JSONDecoder().decode(APIResponse.self, from: data)
                print("Parsed \(response.data.count) movies")
                
                let apiMovies = response.data.map { api in
                    Movie(id: Int(api.id) ?? 0,
                          title: api.title,
                          subtitle: api.director,
                          description: api.plot,
                          imageName: "movie",
                          releaseYear: Int(api.year) ?? 0,
                          rating: Double(api.imdbRating) ?? 0.0,
                          genre: api.genre.components(separatedBy: ",")
                              .map { $0.trimmingCharacters(in: .whitespaces) },
                          posterURL: api.poster)
                }
                
                for movie in apiMovies {
                    SQLiteManager.shared.insertMovie(movie)
                }
                
                self?.movies = SQLiteManager.shared.getAllMovies()
                print("Total movies: \(self?.movies.count ?? 0)")
                
                DispatchQueue.main.async { completion() }
                
            } catch {
                print("Parse error: \(error)")
                if cached.isEmpty { DispatchQueue.main.async { completion() } }
            }
        }.resume()
    }
    
    func addMovie(movie: Movie) {
        var newMovie = movie
        
        if let image = movie.customImage {
            let path = SQLiteManager.shared.saveImage(image, movieId: movie.id)
            newMovie.imagePath = path
        }
        
        movies.append(newMovie)
        SQLiteManager.shared.insertMovie(newMovie)
    }
    
    func deleteMovie(at index: Int) {
        let movie = movies[index]
        SQLiteManager.shared.deleteMovie(id: movie.id)
        movies.remove(at: index)
    }
    
    func getMovie(at index: Int) -> Movie { return movies[index] }
    func moviesCount() -> Int { return movies.count }
}
