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
    

    var movies: [Movie] = [
        Movie(title: "The Dark Knight",
              subtitle: "A Gotham City thriller",
              description: "When the menace known as the Joker wreaks havoc on Gotham, Batman must accept one of the greatest psychological tests.",
              imageName: "movie",
              releaseYear: 2008,
              rating: 9.0,
              genre: ["Action", "Crime", "Drama"]),
        
        Movie(title: "Inception",
              subtitle: "Your mind is the scene of the crime",
              description: "A thief who steals corporate secrets through dream-sharing technology is given the task of planting an idea.",
              imageName: "movie",
              releaseYear: 2010,
              rating: 8.8,
              genre: ["Action", "Sci-Fi", "Thriller"]),
        
        Movie(title: "Interstellar",
              subtitle: "Mankind's next step will be our greatest",
              description: "A team of explorers travel through a wormhole in space to ensure humanity's survival.",
              imageName: "movie",
              releaseYear: 2014,
              rating: 8.6,
              genre: ["Adventure", "Drama", "Sci-Fi"]),
        
        Movie(title: "The Shawshank Redemption",
              subtitle: "Fear can hold you prisoner. Hope can set you free",
              description: "Two imprisoned men bond over a number of years, finding solace and eventual redemption.",
              imageName: "movie",
              releaseYear: 1994,
              rating: 9.3,
              genre: ["Drama"]),
        
        Movie(title: "Pulp Fiction",
              subtitle: "Just because you are a character doesn't mean you have character",
              description: "The lives of two mob hitmen, a boxer, and a pair of diner bandits intertwine in four tales of violence.",
              imageName: "movie",
              releaseYear: 1994,
              rating: 8.9,
              genre: ["Crime", "Drama"])
    ]
    

    func addMovie(movie: Movie) {
        movies.append(movie)
    }
    
    func deleteMovie(at index: Int) {
        movies.remove(at: index)
    }
    
    func getMovie(at index: Int) -> Movie {
        return movies[index]
    }
    
    func moviesCount() -> Int {
        return movies.count
    }
}
