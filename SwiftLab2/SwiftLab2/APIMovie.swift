//
//  APIMovie.swift
//  SwiftLab2
//
//  Created by Bayoumi on 22/04/2026.
//

import Foundation


struct APIResponse: Codable {
    let data: [APIMovie]
}

struct APIMovie: Codable {
    let id: String
    let title: String
    let year: String
    let genre: String
    let plot: String
    let poster: String
    let imdbRating: String
    let director: String
}
