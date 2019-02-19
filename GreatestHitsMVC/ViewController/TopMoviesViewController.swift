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
        
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MovieCell")

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Networking
    
    func fetchTopRatedMovies() {
        
        movies.append(Movie(id: 1, title: "Test", score: 6.7, imageUrl: "https://url.jpg"))
        movies.append(Movie(id: 2, title: "Star", score: 3.7, imageUrl: "https://url.jpg"))
        movies.append(Movie(id: 14, title: "Trench", score: 7.9, imageUrl: "https://url.jpg"))
        movies.append(Movie(id: 12, title: "Golden", score: 6.2, imageUrl: "https://url.jpg"))
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        
        return cell
    }

}
