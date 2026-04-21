//
//  MoviesTableViewController.swift
//  SwiftLab2
//
//  Created by Bayoumi on 15/04/2026.
//

// MoviesTableViewController.swift
import UIKit

class MoviesTableViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        
        let addButton = UIButton(type: .contactAdd)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()  // Refresh when coming back
    }
    
    @objc func addButtonTapped() {
        let addMovieVC = storyboard?.instantiateViewController(withIdentifier: "AddMovieViewController") as! AddMovieViewController
        navigationController?.pushViewController(addMovieVC, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MoviesManager.shared.moviesCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        
        let movie = MoviesManager.shared.getMovie(at: indexPath.row)
        
        if let customImage = movie.customImage {
            cell.imageView?.image = customImage
        } else {
            cell.imageView?.image = UIImage(named: movie.imageName)
        }
        
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
        detailVC.selectedMovie = MoviesManager.shared.getMovie(at: indexPath.row)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            MoviesManager.shared.deleteMovie(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
