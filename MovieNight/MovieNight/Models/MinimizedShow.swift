//
//  Show.swift
//  MovieNight
//
//  Created by Aliaksandr Chekushkin on 3/23/22.
//

import Foundation
import UIKit

struct MinimizedShow {
    let title: String?
    let description: String?
    var poster: UIImage?
    var id: Int?
    var link: String?
    var showType: ShowType?
    
    init(title: String? = nil, description: String? = nil, poster: UIImage? = nil, id: Int? = nil, link: String? = nil, showType: ShowType? = nil) {
        
        self.title = title
        self.description = description
        self.poster = poster
        self.id = id
        self.link = link
        self.showType = showType
    }
}
