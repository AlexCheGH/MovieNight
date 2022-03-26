//
//  DetailedShowManager.swift
//  MovieNight
//
//  Created by Aliaksandr Chekushkin on 3/26/22.
//

import Foundation
import Combine

class DetailedShowManager {
    
    private var linkRequest: VideoLinksRequest?

    @Published private var link: String? = String()
    
    var linkUpdate: AnyPublisher<String?, Never> {
        return $link.map{ $0 }
        .eraseToAnyPublisher()
    }
    
    func loadVideos(show: MinimizedShow?) {
        guard let id = show?.id, let type = show?.showType else { return }

        self.linkRequest = VideoLinksRequest(type: type, id: id)
        self.linkRequest?.execute(withCompletion: { links in
            let key = self.processRawVideoLinks(link: links)
            self.link = LinkBuilder().linkForYoutube(key: key)
        })
    }
    
    private func processRawVideoLinks(link: VideoLinks?) -> String? {
        let youtube = VideoLinks.VideoSource.youtube.rawValue
        let trailer = VideoLinks.VideoType.trailer.rawValue
        
        let result = link?.results?.reduce(into: [String](), { partialResult, result in
            if result.type == trailer && result.site == youtube {
                let entry = result.key
                if let entry = entry {
                    partialResult.append(entry)
                }
            }
        })
        return result?.randomElement()
    }
    
}
