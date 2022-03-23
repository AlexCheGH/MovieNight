//
//  ShowManager.swift
//  MovieNight
//
//  Created by Aliaksandr Chekushkin on 3/23/22.
//

import Foundation
import Combine


class ShowManager {
    
    private var networkRequest: ShowRequest?
    private var posterRequest: PosterImageRequest?

    @Published private var shows: [Show]?
    
    
    //MARK: - Network calls
       func loadShows(type: ShowType, category: Category, genre: Genres, language: Language, sort: SortType, pageNumber: Int) {
           //Start the request to get weather data
           self.networkRequest = ShowRequest(type: type, category: category, genre: genre, language: language, sort: sort, pageNumber: pageNumber)
           
           self.networkRequest?.execute { shows in
               
               //Once data is received, we can initiate a request to get an image
               
           }
       }
       
       //Loads the weather status icon. Weather-Model provides us the image name
       private func loadImage(posterLink: String) {
           self.posterRequest = PosterImageRequest(imageLink: posterLink)
           self.posterRequest?.execute(withCompletion: { image in
               
           })
       }
}
