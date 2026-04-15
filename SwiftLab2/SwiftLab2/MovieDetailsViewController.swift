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

        // Do any additional setup after loading the view.
        if let movie = selectedMovie{
            self.title = movie.title
            movieImage.image = UIImage(named: movie.imageName)
            movieDescription.text = movie.description
            movieRating.text = "Rating: \(movie.rating)/10"
            movieReleaseYear.text =   "Year: \(movie.releaseYear)"
            movieGenre.text = "Genre: \(movie.genre.joined(separator: ", "))"
           
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
