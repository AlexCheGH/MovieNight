//
//  ShowManager.swift
//  MovieNight
//
//  Created by Aliaksandr Chekushkin on 3/23/22.
//

import Foundation
import Combine
import UIKit


class ShowManager {
    
    private var networkRequest: ShowRequest?
    private var posterRequest: PosterImageRequest?

    @Published private var shows: [MinimizedShow]?
    
    
    //MARK: - Network calls
       func loadShows(type: ShowType, category: Category, genre: Genres, language: Language, sort: SortType, pageNumber: Int) {
           //Start the request to get weather data
           self.networkRequest = ShowRequest(type: type, category: category, genre: genre, language: language, sort: sort, pageNumber: pageNumber)
           
           self.networkRequest?.execute { [self] shows in
               processRawShows(shows)
           }
       }
       
       //Loads the weather status icon. Weather-Model provides us the image name
    private func loadImage(posterLink: String, completetion: @escaping(UIImage?) -> Void) {
           self.posterRequest = PosterImageRequest(imageLink: posterLink)
           self.posterRequest?.execute(withCompletion: { image in
               completetion(image)
           })
       }
    
    //MARK: - Processing ShowRaw
    private func processRawShows(_ shows: ShowRaw?) {
        
        shows?.results?.forEach{
            let posterLink = $0.posterPath ?? ""
            let title = $0.name ?? $0.title //name - for tv shows, title - for movies
            let description = $0.overview
            
            let show = MinimizedShow(title: title,
                            description: description,
                            poster: nil)
    
            loadImage(posterLink: posterLink) { image in
                show.poster = image
            }
            
            self.shows?.append(show)
            
        }
        
    }
    
}
