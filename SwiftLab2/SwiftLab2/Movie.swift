//
//  Movie.swift
//  SwiftLab2
//
//  Created by Bayoumi on 15/04/2026.
//
import UIKit
import Foundation

// Movie.swift
import UIKit

struct Movie {
    var id: Int
    var title: String
    var subtitle: String
    var description: String
    var imageName: String
    var releaseYear: Int
    var rating: Double
    var genre: [String]
    var customImage: UIImage?
    var posterURL: String
    var imagePath: String
    
    init(id: Int = 0, title: String, subtitle: String = "",
         description: String, imageName: String = "movie",
         releaseYear: Int, rating: Double, genre: [String],
         customImage: UIImage? = nil, posterURL: String = "",
         imagePath: String = "") {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.imageName = imageName
        self.releaseYear = releaseYear
        self.rating = rating
        self.genre = genre
        self.customImage = customImage
        self.posterURL = posterURL
        self.imagePath = imagePath
    }
}
