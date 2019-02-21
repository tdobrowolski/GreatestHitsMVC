//
//  NetworkKeysModel.swift
//  GreatestHitsMVC
//
//  Created by Tobiasz Dobrowolski on 19/02/2019.
//  Copyright © 2019 Tobiasz Dobrowolski. All rights reserved.
//

import Foundation

enum posterWidths: String {
    case small = "w92"
    case medium = "w154"
    case big = "w342"
}

struct NetworkKeys {
    
    let apiKey: String = "?api_key=25c88c7e914e6fde27a7429fef62b71e"
    let baseImageUrl: String = "https://image.tmdb.org/t/p/"
    let baseUrl: String = "https://api.themoviedb.org/3/"
}
