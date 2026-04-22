//
//  Movie.swift
//  SwiftLab2
//
//  Created by Bayoumi on 15/04/2026.
//
import UIKit
import Foundation


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
}
