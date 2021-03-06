//
//  LinkBuilder.swift
//  MovieNight
//
//  Created by Alex Chekushkin on 3/22/22.
//

import Foundation

class LinkBuilder {
    
    let networkProtocol = "https://"
    let showDomain = "api.themoviedb.org/3/"
    let posterDomain = "image.tmdb.org/t/p/w500"
    let youtubeDomain = "youtube.com/embed/"
    
    private static var apiKey: String {
        get {
            // 1
            guard let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist") else {
                fatalError("Couldn't find file 'ApiKeys.plist'.")
            }
            // 2
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "TMDB_key") as? String else {
                fatalError("Couldn't find key 'weatherKey' in 'ApiKeys.plist'.")
            }
            return value
        }
    }
    
    func makeVideosLink(type: ShowType, showID: Int) -> String {
        let id = String(showID)
        let finalLink = networkProtocol + showDomain + type.rawValue + "/" + id + "/videos" + "?api_key=\(LinkBuilder.apiKey)"
        
        return finalLink

    }
    
    func linkForYoutube(key: String?) -> String {
        guard let link = key else { return "" }
        return networkProtocol + youtubeDomain + link + "?playsinline=1"
    }
    
    func makeLinkForShow(type: ShowType, category: Category, genre: Genres? = nil, language: Language = .eng, sort: SortType, pageNumber: Int) -> String {
        
        let pageNumber = String(pageNumber)
        let genre = genre?.rawValue ?? ""
        
        var startingPath: String {
            if category == .discover {
                return category.rawValue + "/" + type.rawValue
            } else {
                return type.rawValue + "/" + category.rawValue
            }
        }
        
        let link = "\(startingPath)?api_key=\(LinkBuilder.apiKey)&language=\(language.rawValue)&sort_by=\(sort.rawValue)&page=\(pageNumber)&with_genres=\(genre)"
        
        return networkProtocol + showDomain + link
    }
    
    func makePosterLink(link: String) -> String {
        return networkProtocol + posterDomain + link
    }
    
}

//Hardcoded values.
//TODO: change enum to network call.
enum Genres: String {
    
    case action = "28"
    case adventure = "12"
    case animation = "16"
    case comedy = "35"
    case crime = "80"
    case documentary = "99"
    case drama = "18"
    case family = "10751"
    case fantasy = "14"
    case history = "36"
    case horror = "27"
    case music = "10402"
    case mystery = "9648"
    case romance = "10749"
    case scifi = "878"
    case tvMovie = "10770"
    case thriller = "53"
    case war = "10752"
    case western = "37"
    
    func getStringName() -> String {
        
        switch self {
        case .action:
           return "action"
        case .adventure:
           return "adventure"
        case .animation:
           return "animation"
        case .comedy:
           return "comedy"
        case .crime:
           return "crime"
        case .documentary:
           return "documentary"
        case .drama:
           return "drama"
        case .family:
           return "family"
        case .fantasy:
           return "fantasy"
        case .history:
           return "history"
        case .horror:
           return "horror"
        case .music:
           return "music"
        case .mystery:
           return "mystery"
        case .romance:
           return "romance"
        case .scifi:
           return "scifi"
        case .tvMovie:
           return "tvMovie"
        case .thriller:
           return "thriller"
        case .war:
           return "war"
        case .western:
           return "western"
        }
    }
    
}

//Suplements to network calls, can be continued
enum Language: String {
    case eng = "en-US"
}

enum ShowType: String {
    case movie = "movie"
    case tvShow = "tv"
}

enum Category: String {
    case discover = "discover"
    case popular = "popular"
}

enum SortType: String {
    case popularity = "popularity.desc"
}
