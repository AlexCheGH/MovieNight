//
//  ViewController.swift
//  MovieNight
//
//  Created by Alex Chekushkin on 3/22/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let showManager = ShowManager()
        showManager.loadShows(type: .tvShow, category: .discover, genre: .crime, language: .eng, sort: .popularity, pageNumber: 1)
        
        
        
    }


}

