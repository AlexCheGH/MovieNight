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

class ShowManager {
    
    private var networkRequest: ShowRequest?
    private var posterRequest: PosterImageRequest?
    
    @Published var model: [ShowCategory]? = [ShowCategory]()
    
    var modelUpdate: AnyPublisher<[ShowCategory]?, Never> {
        return $model.map{ $0 }
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
            
            shows?.results?.forEach{ item in
                loadImage(posterLink: item.posterPath ?? "") { image in
                    let show = processRawShows(item, image: image)
                    
                    addShows(genre: genre?.getStringName(), show: show, type: type)
                }
            }
        }
    }
    
    //Loads the weather status icon. Weather-Model provides us the image name
    private func loadImage(posterLink: String, completetion: @escaping(UIImage?) -> Void) {
        self.posterRequest = PosterImageRequest(imageLink: posterLink)
        self.posterRequest?.execute(withCompletion: { image in
            completetion(image)
        })
    }
    
    func loadDefaultCollection() {
        loadShows(type: .movie, category: .popular, genre: .scifi, language: .eng, sort: .popularity, pageNumber: 1)
        loadShows(type: .tvShow, category: .popular, genre: .animation, language: .eng, sort: .popularity, pageNumber: 1)
        loadShows(type: .movie, category: .discover, genre: .family, language: .eng, sort: .popularity, pageNumber: 1)
        loadShows(type: .movie, category: .discover, genre: .documentary, language: .eng, sort: .popularity, pageNumber: 1)
        loadShows(type: .tvShow, category: .discover, genre: .family, language: .eng, sort: .popularity, pageNumber: 1)
        loadShows(type: .tvShow, category: .discover, genre: .documentary, language: .eng, sort: .popularity, pageNumber: 1)
    }
    
    //MARK: - Processing ShowRaw, adding the variant to model
    private func processRawShows(_ shows: ResultRaw?, image: UIImage?) -> MinimizedShow {
        //name - for tv shows, title - for movies
        let title = shows?.name ?? shows?.title
        let description = shows?.overview
        
        let show = MinimizedShow(title: title,
                                 description: description,
                                 poster: image)
        
        return show
    }
    
   private func addShows(genre: String?, show: MinimizedShow, type: ShowType) {
        let showCaterogy = ShowCategory(showList: [], genre: genre, type: type)
        //checks if the model already contains said showCategory
       
       var isModelMatchingParameters: Bool {
           (model!.contains{
               let genre = $0.genre == showCaterogy.genre
               let type = $0.type == showCaterogy.type
               
               return genre && type
           })
       }
       
        if isModelMatchingParameters {
            let index = model?.firstIndex{
                let isMatchingGenre = $0.genre == showCaterogy.genre
                let isMatchingType = $0.type == showCaterogy.type
                
                return isMatchingType && isMatchingGenre
            }
            //if it does - adds show to the existing array
            model![index!].showList?.append(show)
        } else {
            //if not - adds category to the model
            showCaterogy.showList?.append(show)
            model?.append(showCaterogy)
        }
       //send an update to refresh data
       self.model = model
       
    }
}
