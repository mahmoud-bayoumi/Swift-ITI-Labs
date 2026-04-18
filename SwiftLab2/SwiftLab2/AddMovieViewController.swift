//
//  AddMovieViewController.swift
//  SwiftLab2
//
//  Created by Bayoumi on 18/04/2026.
//

import UIKit

class AddMovieViewController: UIViewController {

    
    @IBOutlet weak var movieGenreTextField: UITextField!
    @IBOutlet weak var movieReleaseYearTextField: UITextField!
    @IBOutlet weak var movieRatingTextField: UITextField!
    @IBOutlet weak var movieDescriptionTextView: UITextView!
    @IBOutlet weak var movieNameTextField: UITextField!
    
    var delegate: MoviesProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Movie"
        
        movieDescriptionTextView.layer.borderWidth = 0.5
        movieDescriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        movieDescriptionTextView.layer.cornerRadius = 5.0
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneBtnAction(_ sender: UIButton) {
        
        guard let name = movieNameTextField.text, !name.isEmpty,
                   let description = movieDescriptionTextView.text, !description.isEmpty,
                   let ratingText = movieRatingTextField.text, let rating = Double(ratingText),
                   let yearText = movieReleaseYearTextField.text, let year = Int(yearText),
                   let genreText = movieGenreTextField.text, !genreText.isEmpty
        else {
            let alert = UIAlertController(title: "Error",
                                                   message: "Please fill all fields",
                                                   preferredStyle: .alert)
                     alert.addAction(UIAlertAction(title: "OK", style: .default))
                     present(alert, animated: true)
                     return
            
        }
        
        let genres = genreText.components(separatedBy:",").map{$0.trimmingCharacters(in: .whitespaces) }
               
               
               let newMovie = Movie(title: name,
                                    subtitle: "",
                                    description: description,
                                    imageName: "movie",
                                    releaseYear: year,
                                    rating: rating,
                                    genre: genres)
               
               delegate?.addMovie(movie: newMovie)
               navigationController?.popViewController(animated: true)
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        guard let name = movieNameTextField.text, !name.isEmpty,
              let description = movieDescriptionTextView.text, !description.isEmpty,
              let ratingText = movieRatingTextField.text, let _ = Double(ratingText),
              let yearText = movieReleaseYearTextField.text, let _ = Int(yearText),
              let genreText = movieGenreTextField.text, !genreText.isEmpty
        else {
            let alert = UIAlertController(
                title: "Error",
                message: "Please fill all fields correctly!",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return false  // Block segue
        }
        
        return true  // All fields valid → Allow segue
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          
          let name = movieNameTextField.text!
          let description = movieDescriptionTextView.text!
          let rating = Double(movieRatingTextField.text!)!
          let year = Int(movieReleaseYearTextField.text!)!
          let genres = movieGenreTextField.text!
              .components(separatedBy: ",")
              .map { $0.trimmingCharacters(in: .whitespaces) }
          
          let newMovie = Movie(title: name,
                               subtitle: "",
                               description: description,
                               imageName: "movie",
                               releaseYear: year,
                               rating: rating,
                               genre: genres)
          
          delegate?.addMovie(movie: newMovie)
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
