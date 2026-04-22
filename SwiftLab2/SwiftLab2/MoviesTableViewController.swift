//
//  MoviesTableViewController.swift
//  SwiftLab2
//
//  Created by Bayoumi on 15/04/2026.
//

import UIKit

class MoviesTableViewController: UITableViewController {
    
    let indicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        
        let addButton = UIButton(type: .contactAdd)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
        
        setupIndicator()
        loadMovies()
    }
    
    func setupIndicator() {
        indicator.color = .systemBlue
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func loadMovies() {
        indicator.startAnimating()
        
        MoviesManager.shared.loadMovies { [weak self] in
            print("Reloading table with \(MoviesManager.shared.moviesCount()) movies")
            self?.indicator.stopAnimating()
            self?.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc func addButtonTapped() {
        let addMovieVC = storyboard?.instantiateViewController(withIdentifier: "AddMovieViewController") as! AddMovieViewController
        navigationController?.pushViewController(addMovieVC, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = MoviesManager.shared.moviesCount()
        print("numberOfRows: \(count)")
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        let movie = MoviesManager.shared.getMovie(at: indexPath.row)
        
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = "\(movie.rating) | \(movie.releaseYear)"
        
        if let customImage = movie.customImage {
            cell.imageView?.image = customImage
        } else if !movie.posterURL.isEmpty, let url = URL(string: movie.posterURL) {
            cell.imageView?.image = UIImage(named: "movie")
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.imageView?.image = image
                        cell.setNeedsLayout()
                    }
                }
            }.resume()
        } else {
            cell.imageView?.image = UIImage(named: "movie")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
