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

    @Published var shows: [MinimizedShow]? = [MinimizedShow]()
    
    var currentShows: AnyPublisher<[MinimizedShow]?, Never> {
        return $shows.map{ $0 }
        .eraseToAnyPublisher()
    }
    
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
    
            //Once the main network call has completed, we can start init poster image.
            loadImage(posterLink: posterLink) { image in
                //getting the index of element in the main array
                guard let index = (self.shows?.firstIndex{ $0.title == show.title }) else { return }
                if self.shows != nil {
                    //changing the image from nil to value
                    self.shows![index].poster = image
                }
            }
            self.shows?.append(show)
        }
    }
}
