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
            completion()
        }
        
        guard let url = URL(string: "https://fooapi.com/api/movies") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                print("API Error: \(error?.localizedDescription ?? "Unknown")")
                if cached.isEmpty { DispatchQueue.main.async { completion() } }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(APIResponse.self, from: data)
                
                let movies = response.data.map { api in
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
                
                SQLiteManager.shared.deleteAll()
                movies.forEach { SQLiteManager.shared.insertMovie($0) }
                
                self.movies = movies
                print("Fetched \(movies.count) movies")
                
                DispatchQueue.main.async { completion() }
                
            } catch {
                print("Parse error: \(error)")
                if cached.isEmpty { DispatchQueue.main.async { completion() } }
            }
        }.resume()
    }
    
    func addMovie(movie: Movie) {
        movies.append(movie)
        SQLiteManager.shared.insertMovie(movie)
    }
    
    func deleteMovie(at index: Int) {
        let movie = movies[index]
        SQLiteManager.shared.deleteMovie(id: movie.id)
        movies.remove(at: index)
    }
    
    func getMovie(at index: Int) -> Movie { return movies[index] }
    func moviesCount() -> Int { return movies.count }
}
