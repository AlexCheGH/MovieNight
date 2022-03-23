//
//  Show.swift
//  MovieNight
//
//  Created by Aliaksandr Chekushkin on 3/23/22.
//

import Foundation
import UIKit

class Show {
    let title: String?
    let description: String?
    let poster: UIImage?
    let productionCompany: String?
    let originCountry: String?
    let homepage: String?
    
    init(title: String? = nil, description: String? = nil, poster: UIImage? = nil, productionCompany: String? = nil, originCountry: String? = nil, homepage: String? = nil) {
    
    self.title = title
    self.description = description
    self.poster = poster
    self.productionCompany = productionCompany
    self.originCountry = originCountry
    self.homepage = homepage
    }
}

