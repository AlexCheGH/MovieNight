//
//  DetailedShowInfoViewController.swift
//  MovieNight
//
//  Created by Aliaksandr Chekushkin on 3/24/22.
//

import UIKit
import WebKit
import Combine

class DetailedShowInfoViewController: UIViewController {
    
    private var model: MinimizedShow?
    private let webView = DetailedMovieView.loadViewFromNib()
    private let manager = DetailedShowManager()
    
    private var linkUpdateSubscriber: AnyCancellable?
    
    override func viewDidLoad() {
        view.addSubview(webView)
        webView.frame.size = view.frame.size
        
        configureSubscriber()
    }
    
    func configureViewController(show: MinimizedShow?) {
        self.model = show        
        manager.loadVideos(show: show)
    }
    
    private func configureSubscriber() {
        linkUpdateSubscriber = manager.linkUpdate
            .receive(on: RunLoop.main)
            .sink(receiveValue: { link in
                guard let link = link else { return }
                self.webView.configureView(model: self.model, youTubeLink: link)
                self.view.layoutSubviews()
                print(link)
            })
    }
    
    
}
