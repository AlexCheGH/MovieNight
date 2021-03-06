//
//  PopularMovies.swift
//  MovieNight
//
//  Created by Alex Chekushkin on 3/22/22.
//

import Foundation

// MARK: - PopularMovies
class ShowRaw: Codable {
    let page: Int?
    let results: [ResultRaw]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    init(page: Int?, results: [ResultRaw]?, totalPages: Int?, totalResults: Int?) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}

//Documentation: https://developers.themoviedb.org/3/movies/get-popular-movies
