//
//  ViewController.swift
//  MovieNight
//
//  Created by Alex Chekushkin on 3/22/22.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let cellHeight: CGFloat = 200
    
    private let showManager = ShowManager()
    private var showSubscriber: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showManager.loadShows(type: .movie, category: .discover, genre: .fantasy, language: .eng, sort: .popularity, pageNumber: 1)
        
        configureTableView()
        configureShowSubscriber()
        
        
    }
    
    private func configureTableView() {
        tableView.register(CollectionTabeViewCell.nib(), forCellReuseIdentifier: CollectionTabeViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .blue
    }
    
    private func configureShowSubscriber() {
        showSubscriber = showManager.currentShows
            .receive(on: RunLoop.main)
            .sink(receiveValue: { value in
                
                let indexPath = IndexPath(item: 0, section: 0)
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            })
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTabeViewCell.identifier, for: indexPath) as! CollectionTabeViewCell
        
        cell.model = showManager.shows
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cellHeight
    }
    
}
