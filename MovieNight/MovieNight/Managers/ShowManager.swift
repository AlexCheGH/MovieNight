//
//  ShowManager.swift
//  MovieNight
//
//  Created by Aliaksandr Chekushkin on 3/23/22.
//

import Foundation
import Combine
import UIKit


class ShowCategory {
    
    var showList: [MinimizedShow]?
    var genre: String? //the category name
    
    init(showList: [MinimizedShow]?, genre: String?) {
        self.genre = genre
        self.showList = showList
    }
    
}

class ShowManager {
    
    private var networkRequest: ShowRequest?
    private var posterRequest: PosterImageRequest?

    @Published var shows: [MinimizedShow]? = [MinimizedShow]()
    @Published var model: [ShowCategory]?
    
    var currentShows: AnyPublisher<[MinimizedShow]?, Never> {
        return $shows.map{ $0 }
        .eraseToAnyPublisher()
    }
    
    init() {
        loadDefaultCollection()
    }
    
    //MARK: - Network calls
       func loadShows(type: ShowType, category: Category, genre: Genres?, language: Language, sort: SortType, pageNumber: Int) {
           //Start the request to get weather data
           self.networkRequest = ShowRequest(type: type, category: category, genre: genre, language: language, sort: sort, pageNumber: pageNumber)
           
           self.networkRequest?.execute { [self] shows in
               processRawShows(shows)
               addToModel(shows: self.shows, genre: genre?.getStringName())
               
           }
           self.shows?.removeAll()
       }
       
       //Loads the weather status icon. Weather-Model provides us the image name
    private func loadImage(posterLink: String, completetion: @escaping(UIImage?) -> Void) {
           self.posterRequest = PosterImageRequest(imageLink: posterLink)
           self.posterRequest?.execute(withCompletion: { image in
               completetion(image)
           })
       }
    
    func loadDefaultCollection() {
        loadShows(type: .movie, category: .popular, genre: nil, language: .eng, sort: .popularity, pageNumber: 1)
        loadShows(type: .tvShow, category: .popular, genre: nil, language: .eng, sort: .popularity, pageNumber: 1)
        loadShows(type: .movie, category: .discover, genre: .family, language: .eng, sort: .popularity, pageNumber: 1)
        loadShows(type: .movie, category: .discover, genre: .documentary, language: .eng, sort: .popularity, pageNumber: 1)
        loadShows(type: .tvShow, category: .discover, genre: .family, language: .eng, sort: .popularity, pageNumber: 1)
        loadShows(type: .tvShow, category: .discover, genre: .documentary, language: .eng, sort: .popularity, pageNumber: 1)
    }
    
    //MARK: - Processing ShowRaw, adding the variant to model
    private func processRawShows(_ shows: ShowRaw?) {
        var tempShowsArray = [MinimizedShow]()
        
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
                
                guard let index = (tempShowsArray.firstIndex{ $0.title == show.title }) else { return }
                tempShowsArray[index].poster = image
                
                
                
                
            }
            tempShowsArray.append(show)
            self.shows?.append(show)
        }
    }
    
    private func addToModel(shows: [MinimizedShow]?, genre: String?) {
        let showCategory = ShowCategory(showList: shows, genre: genre)
        self.model?.append(showCategory)
        
    }
    
}
