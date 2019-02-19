//
//  TopMoviesViewController.swift
//  GreatestHitsMVC
//
//  Created by Tobiasz Dobrowolski on 19/02/2019.
//  Copyright © 2019 Tobiasz Dobrowolski. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TopMoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Data
    
    var movies: [Movie] = []
    var nextUrl: Int? = nil
    var totalNextPages: Int? = nil
    
    let networkKeys: NetworkKeys = NetworkKeys()
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Top rated movies"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Options", style: .plain, target: self, action: #selector(goToOptions(_:)))
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
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
        
        let url = networkKeys.baseUrl + "movie/top_rated" + networkKeys.apiKey
        print(url)
        
        Alamofire.request(url).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                self.nextUrl = json["page"].intValue
                
                if self.totalNextPages == nil {
                    self.totalNextPages = json["total_pages"].intValue
                }
                
                let resultsJson = json["results"]
                
                for (index, subJson) : (String, JSON) in resultsJson {
                    self.movies.append(Movie(id: subJson["id"].intValue,
                                             title: subJson["title"].stringValue,
                                             score: subJson["vote_average"].doubleValue,
                                             imageUrl: subJson["poster_path"].stringValue))
                }
                
                self.tableView.reloadData()
                
            case .failure(let error):
                print("Failure response: \(error)")
            }
            
        }
        
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
        movieDetailViewController.passedModel = movies[indexPath.row]
        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }

}
