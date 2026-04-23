//
//  AddMovieViewController.swift
//  SwiftLab2
//
//  Created by Bayoumi on 18/04/2026.
//

import UIKit

class AddMovieViewController: UIViewController,
                              UIImagePickerControllerDelegate,
                              UINavigationControllerDelegate {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieGenreTextField: UITextField!
    @IBOutlet weak var movieReleaseYearTextField: UITextField!
    @IBOutlet weak var movieRatingTextField: UITextField!
    @IBOutlet weak var movieDescriptionTextView: UITextView!
    @IBOutlet weak var movieNameTextField: UITextField!
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Movie"
        
        movieDescriptionTextView.layer.borderWidth = 0.5
        movieDescriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        movieDescriptionTextView.layer.cornerRadius = 5.0
        
        movieImage.isUserInteractionEnabled = true
        movieImage.image = UIImage(systemName: "photo.badge.plus")
        let tap = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        movieImage.addGestureRecognizer(tap)
    }
    
    @objc func pickImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        if let image = info[.editedImage] as? UIImage {
            selectedImage = image
            movieImage.image = image
        } else if let image = info[.originalImage] as? UIImage {
            selectedImage = image
            movieImage.image = image
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
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
        
        let genres = genreText.components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }
        
        let nextId = Int(Date().timeIntervalSince1970)
        
        let newMovie = Movie(
            id: nextId,
            title: name,
            subtitle: "",
            description: description,
            imageName: "movie",
            releaseYear: year,
            rating: rating,
            genre: genres,
            customImage: selectedImage,
            posterURL: ""
        )
        
        CoreDataManager.shared.saveMovie(movie: newMovie)
        navigationController?.popViewController(animated: true)
    }
}
