//
//  DetailedShowInfoViewController.swift
//  MovieNight
//
//  Created by Aliaksandr Chekushkin on 3/24/22.
//

import UIKit
import WebKit

class DetailedShowInfoViewController: UIViewController {
    
    var show: MinimizedShow?
    let webView = DetailedMovieView.loadViewFromNib()
    
    override func viewDidLoad() {
        
        view.addSubview(webView)
        webView.frame.size = view.frame.size
        
        webView.configureView(model: show)
        
    }
    
    
}
