//
//  MovieDetailsStaticTableViewController.swift
//  SwiftLab2
//
//  Created by Bayoumi on 26/04/2026.
//

import UIKit

class MovieDetailsStaticTableViewController: UITableViewController {

  
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var moviesImageView: UIImageView!
    
    var selectedMovie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        guard let movie = selectedMovie else { return }
        
        self.title = movie.title
        genreLabel.text = movie.genre.joined(separator: ", ")
        releaseYearLabel.text = "\(movie.releaseYear)"
        ratingLabel.text = "\(movie.rating)/10"
        descriptionTextView.text = movie.description
        
       
        if let customImage = movie.customImage {
            moviesImageView.image = customImage
        }
      
        else if !movie.imagePath.isEmpty {
            let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fullPath = docs.appendingPathComponent(movie.imagePath).path
            
            if FileManager.default.fileExists(atPath: fullPath) {
                moviesImageView.image = UIImage(contentsOfFile: fullPath)
            } else {
                
                moviesImageView.image = UIImage(named: movie.imageName)
            }
        }
        else if !movie.posterURL.isEmpty, let url = URL(string: movie.posterURL) {
            moviesImageView.image = UIImage(named: "placeholder")
            
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.moviesImageView.image = image
                    }
                }
            }.resume()
        } else {
            moviesImageView.image = UIImage(named: movie.imageName)
        }
    }
    // MARK: - CRITICAL FOR STATIC CELLS
    // We DELETE numberOfSections and numberOfRowsInSection.
    // If these remain and return 0, your static cells will be invisible.
}
