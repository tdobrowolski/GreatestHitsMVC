//
//  MovieDetailViewController.swift
//  GreatestHitsMVC
//
//  Created by Tobiasz Dobrowolski on 19/02/2019.
//  Copyright © 2019 Tobiasz Dobrowolski. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var passedModel: Movie?
    
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
        setupPassedData()
    }
    
    func setupImageView() {
        
        shadowView.layer.cornerRadius = 8
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 8)
        shadowView.layer.shadowOpacity = 0.4
        shadowView.layer.shadowRadius = 12
        shadowView.backgroundColor = UIColor.white
        
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 8
    }
    
    func setupPassedData() {
        
        if let passedModel = passedModel {
            titleTextView.text = passedModel.title
            userScoreLabel.text = "User score: \(passedModel.score) / 10"
            setupImageView()
        }
    }
    
}
