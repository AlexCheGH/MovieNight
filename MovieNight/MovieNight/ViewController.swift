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
        
        let request = ShowRequest(type: .tvShow, category: .popular, genre: .comedy, language: .eng, sort: .popularity, pageNumber: 1)
        
        request.execute { value in
            print(value?.results)
        }
        
    }


}

