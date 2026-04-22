//
//  MovieDetailsViewController.swift
//  SwiftLab2
//
//  Created by Bayoumi on 15/04/2026.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieReleaseYear: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    var selectedMovie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = selectedMovie {
            self.title = movie.title
            movieDescription.text = movie.description
            movieRating.text = "Rating  \(movie.rating)/10"
            movieReleaseYear.text = "Release Year \(movie.releaseYear)"
            movieGenre.text = "Genre \(movie.genre.joined(separator: ", "))"
            
            if !movie.posterURL.isEmpty, let url = URL(string: movie.posterURL) {
                URLSession.shared.dataTask(with: url) { data, _, _ in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.movieImage.image = image
                        }
                    }
                }.resume()
            } else {
                movieImage.image = UIImage(named: movie.imageName)
            }
        }
    }
}
