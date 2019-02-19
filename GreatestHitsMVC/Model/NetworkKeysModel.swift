//
//  NetworkKeysModel.swift
//  GreatestHitsMVC
//
//  Created by Tobiasz Dobrowolski on 19/02/2019.
//  Copyright © 2019 Tobiasz Dobrowolski. All rights reserved.
//

import Foundation

struct NetworkKeys {
    
    enum posterWidths: String {
        case w92 = "w92"
        case w154 = "w154"
        case w342 = "w342"
    }
    
    let apiKey: String = "?api_key=25c88c7e914e6fde27a7429fef62b71e"
    let baseImageUrl: String = "https://image.tmdb.org/t/p/"
    let baseUrl: String = "https://api.themoviedb.org/3/"
    //let posterSizes: posterWidths
}
