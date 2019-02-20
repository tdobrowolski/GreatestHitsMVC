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
import Kingfisher

class TopMoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Data
    
    var movies: [Movie] = []
    var nextInt: Int = 1
    var totalNextPages: Int = 0
    var isLoading: Bool = false
    
    let networkKeys: NetworkKeys = NetworkKeys()
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Top rated movies"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Options", style: .plain, target: self, action: #selector(goToOptions(_:)))
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red:0.02, green:0.75, blue:0.43, alpha:1.0)]
        
        let mainCellNib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(mainCellNib, forCellReuseIdentifier: "MovieCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchTopRatedMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    @objc func goToOptions(_ sender: UIButton) {
        print("Go to Options")
    }
    
    // MARK: - Networking
    
    func fetchTopRatedMovies() {
        
        let url = networkKeys.baseUrl + "movie/top_rated" + networkKeys.apiKey + "&page=" + String(nextInt)
        print(url)
        
        Alamofire.request(url).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                self.nextInt = json["page"].intValue + 1
                
                if self.totalNextPages == 0 {
                    self.totalNextPages = json["total_pages"].intValue
                }
                
                let resultsJson = json["results"]
                
                for (_, subJson) : (String, JSON) in resultsJson {
                    self.movies.append(Movie(id: subJson["id"].intValue,
                                             title: subJson["title"].stringValue,
                                             score: subJson["vote_average"].doubleValue,
                                             imageUrl: subJson["poster_path"].stringValue))
                }
                
                self.isLoading = false
                self.tableView.reloadData()
                
            case .failure(let error):
                print("Failure response: \(error)")
                self.isLoading = false
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
        cell.posterImageView.kf.setImage(with: URL(string: networkKeys.baseImageUrl + "w92" + movies[indexPath.row].imageUrl), placeholder: UIImage(named: "placeholder"), options: [.transition(.fade(0.2))])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailViewController = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil)
        movieDetailViewController.passedMovieModel = movies[indexPath.row]
        movieDetailViewController.passedNetworkKeysModel = networkKeys
        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 125
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height * 2, !isLoading, nextInt <= totalNextPages {
            print("Fetching")
            isLoading = true
            fetchTopRatedMovies()
        }
    }
}
