//
//  MovieModel.swift
//  GreatestHitsMVC
//
//  Created by Tobiasz Dobrowolski on 19/02/2019.
//  Copyright © 2019 Tobiasz Dobrowolski. All rights reserved.
//

import Foundation

struct Movie {
    
    let id: Int
    let title: String
    let score: Double
    let imageUrl: String
    
    let overview: String? = nil
    let genres: [String]? = nil
    let releaseDate: Date? = nil
    let revenue: Int? = nil
    
    init(id: Int, title: String, score: Double, imageUrl: String) {
        self.id = id
        self.title = title
        self.score = score
        self.imageUrl = imageUrl
    }
    
}
