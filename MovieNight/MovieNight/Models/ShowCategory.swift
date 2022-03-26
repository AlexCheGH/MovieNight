//
//  ShowCategory.swift
//  MovieNight
//
//  Created by Aliaksandr Chekushkin on 3/25/22.
//

import Foundation

class ShowCategory {
    
    var showList: [MinimizedShow]?
    let genre: String? //the category name
    let type: ShowType?
    var category: String? {
        return (genre?.capitalizingFirstLetter() ?? "")  + " " + (type?.rawValue.capitalizingFirstLetter() ?? "")
    }
    
    init(showList: [MinimizedShow]?, genre: String?, type: ShowType?) {
        self.genre = genre
        self.showList = showList
        self.type = type
    }
    
}
