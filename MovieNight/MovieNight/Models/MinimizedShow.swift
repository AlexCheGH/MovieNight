//
//  Show.swift
//  MovieNight
//
//  Created by Aliaksandr Chekushkin on 3/23/22.
//

import Foundation
import UIKit

class MinimizedShow {
    let title: String?
    let description: String?
    var poster: UIImage?
    
    init(title: String? = nil, description: String? = nil, poster: UIImage? = nil) {
    
    self.title = title
    self.description = description
    self.poster = poster
    }
}

