//
//  String +.swift
//  MovieNight
//
//  Created by Aliaksandr Chekushkin on 3/24/22.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
