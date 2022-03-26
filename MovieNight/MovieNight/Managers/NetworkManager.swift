//
//  NetworkManager.swift
//  MovieNight
//
//  Created by Alex Chekushkin on 3/22/22.
//

import Foundation
import UIKit

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func execute(withCompletion completion: @escaping (ModelType?) -> Void)
}

extension NetworkRequest {
    func makeRequest(url: URL, completion: @escaping(ModelType?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let value = self.decode(data)  else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            DispatchQueue.main.async {
                completion(value)
            }
        }.resume()
    }
}


class ShowRequest {
    let url: URL
    
    init(type: ShowType, category: Category, genre: Genres?, language: Language, sort: SortType, pageNumber: Int) {
        let link = LinkBuilder().makeLinkForShow(type: type, category: category, genre: genre, language: language, sort: sort, pageNumber: pageNumber)
        self.url = URL(string: link)!
    }
    
}

extension ShowRequest: NetworkRequest {
    typealias ModelType = ShowRaw
    
    func decode(_ data: Data) -> ShowRaw? {
        let decoder = JSONDecoder()
        let show = try? decoder.decode(ModelType.self, from: data)
        
        return show
    }
    
    func execute(withCompletion completion: @escaping (ShowRaw?) -> Void) {
        makeRequest(url: url, completion: completion)
    }
}


class PosterImageRequest {
    let url: URL
    
    init(imageLink: String) {
        let link = LinkBuilder().makePosterLink(link: imageLink)
        self.url = URL(string: link)!
    }
}

extension PosterImageRequest: NetworkRequest {
    
    typealias ModelType = UIImage
    
    func decode(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }
    
    func execute(withCompletion completion: @escaping (UIImage?) -> Void) {
        makeRequest(url: url, completion: completion)
    }
}

class VideoLinksRequest {
    let url: URL
    
    init(type: ShowType, id: Int) {
        let link = LinkBuilder().makeVideosLink(type: type, showID: id)
        self.url = URL(string: link)!
    }
}

extension VideoLinksRequest: NetworkRequest {
    typealias ModelType = VideoLinks
    
    func decode(_ data: Data) -> VideoLinks? {
        let decoder = JSONDecoder()
        let links = try? decoder.decode(VideoLinks.self, from: data)
        
        return links
    }
    
    func execute(withCompletion completion: @escaping (VideoLinks?) -> Void) {
        makeRequest(url: url, completion: completion)
    }
}
