//
//  MoviesTableViewController.swift
//  SwiftLab2
//
//  Created by Bayoumi on 15/04/2026.
//

import UIKit

class MoviesTableViewController: UITableViewController {
    let movies: [Movie] = [
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)

        let movie = movies[indexPath.row]
        cell.imageView?.image = UIImage(named: movie.imageName)
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = movie.subtitle


        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        detailVC.selectedMovie = movies[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
  

}
