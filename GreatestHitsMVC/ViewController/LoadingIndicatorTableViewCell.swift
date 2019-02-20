//
//  LoadingIndicatorTableViewCell.swift
//  GreatestHitsMVC
//
//  Created by Tobiasz Dobrowolski on 20/02/2019.
//  Copyright © 2019 Tobiasz Dobrowolski. All rights reserved.
//

import UIKit

class LoadingIndicatorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
