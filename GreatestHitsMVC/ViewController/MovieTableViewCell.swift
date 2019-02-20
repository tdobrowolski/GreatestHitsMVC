//
//  MovieTableViewCell.swift
//  GreatestHitsMVC
//
//  Created by Tobiasz Dobrowolski on 19/02/2019.
//  Copyright © 2019 Tobiasz Dobrowolski. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var userScoreLabel: UILabel!
    
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
