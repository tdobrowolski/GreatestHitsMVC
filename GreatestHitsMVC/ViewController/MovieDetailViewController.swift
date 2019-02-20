//
//  MovieDetailViewController.swift
//  GreatestHitsMVC
//
//  Created by Tobiasz Dobrowolski on 19/02/2019.
//  Copyright © 2019 Tobiasz Dobrowolski. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class MovieDetailViewController: UIViewController {
    
    var passedMovieModel: Movie?
    var passedNetworkKeysModel: NetworkKeys?
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var userScoreLabel: UILabel!
    
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.tintColor = UIColor(red:0.02, green:0.75, blue:0.43, alpha:1.0)
        self.genresLabel.numberOfLines = 0
        
        if let passedMovieModel = passedMovieModel, let passedNetworkKeysModel = passedNetworkKeysModel {
            
            let url = passedNetworkKeysModel.baseUrl + "movie/" + String(passedMovieModel.id) + passedNetworkKeysModel.apiKey
            let imageUrl = passedNetworkKeysModel.baseImageUrl + "w342" + passedMovieModel.imageUrl
            
            setupPassedData()
            setupImageView(imageUrl: imageUrl)
            fetchDetailMovieData(url: url)
        }
    }
    
    func convertDate(_ dateString: String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = formatter.date(from: dateString)
        formatter.dateFormat = "dd MMM yyyy"
        
        return formatter.string(from: formattedDate!)
    }
    
    func convertNumber(_ numberString: String) -> String {

        let num: NSNumber = NSNumber.init(value: Int64(numberString)!)
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        
        return "$" + formatter.string(from: num)! + ".00"
    }
    
    func fetchDetailMovieData(url: String) {
        
        print(url)
        
        Alamofire.request(url).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                let genresJson = json["genres"]
                
                var genresArray: [String] = []
                
                for (_, subJson) : (String, JSON) in genresJson {
                    genresArray.append(subJson["name"].stringValue)
                }
                
                let revenue = json["revenue"].stringValue
                
                // Updating UI
                self.overviewTextView.text = json["overview"].stringValue
                self.genresLabel.text = genresArray.joined(separator: ", ")
                self.dateLabel.text = self.convertDate(json["release_date"].stringValue)
                
                if revenue != "0" {
                    self.revenueLabel.text = self.convertNumber(revenue)
                } else {
                    self.revenueLabel.text = "N/A"
                }
                
            case .failure(let error):
                print("Failure response: \(error)")
            }
        }
        
    }
    
    func setupImageView(imageUrl: String) {
        
        shadowView.layer.cornerRadius = 8
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 8)
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.shadowRadius = 10
        shadowView.backgroundColor = UIColor.white
        
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 8
        
        print(imageUrl)
        self.posterImageView.kf.indicatorType = .activity
        self.posterImageView.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(named: "placeholder"), options: [.transition(.fade(0.2))])
    }
    
    func setupPassedData() {
        
        titleTextView.text = passedMovieModel!.title
        userScoreLabel.text = "User score: \(passedMovieModel!.score) / 10"
    }
}

