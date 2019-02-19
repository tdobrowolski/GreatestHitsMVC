//
//  TopMoviesViewController.swift
//  GreatestHitsMVC
//
//  Created by Tobiasz Dobrowolski on 19/02/2019.
//  Copyright © 2019 Tobiasz Dobrowolski. All rights reserved.
//

import UIKit

class TopMoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Data
    
    var movies: [Movie] = []
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Top rated movies"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Options", style: .plain, target: self, action: #selector(goToOptions(_:)))
        
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MovieCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchTopRatedMovies()
    }
    
    @objc func goToOptions(_ sender: UIButton) {
        print("Go to Options")
    }
    
    // MARK: - Networking
    
    func fetchTopRatedMovies() {
        
        movies.append(Movie(id: 1, title: "Test", score: 6.7, imageUrl: "https://url.jpg"))
        movies.append(Movie(id: 2, title: "Star", score: 3.7, imageUrl: "https://url.jpg"))
        movies.append(Movie(id: 14, title: "Trench", score: 7.9, imageUrl: "https://url.jpg"))
        movies.append(Movie(id: 12, title: "Golden", score: 6.2, imageUrl: "https://url.jpg"))
        
        tableView.reloadData()
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        cell.titleTextView.text = movies[indexPath.row].title
        cell.userScoreLabel.text = "User score: \(movies[indexPath.row].score) / 10"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailViewController = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil)
        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }

}
