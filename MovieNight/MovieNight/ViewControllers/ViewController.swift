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
    
    private let cellHeight: CGFloat = 300
    
    private let showManager = ShowManager(loadDefaultContent: true)
    private var showSubscriber: AnyCancellable?
    private var categorySubscriber: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureCategorySubscriber()
        
    }
    
    private func configureTableView() {
        tableView.register(CollectionTabeViewCell.nib(), forCellReuseIdentifier: CollectionTabeViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureCategorySubscriber() {
        categorySubscriber = showManager.modelUpdate
            .receive(on: RunLoop.main)
            .sink(receiveValue: { value in
                
                self.tableView.reloadData()
            })
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTabeViewCell.identifier, for: indexPath) as! CollectionTabeViewCell
        
        guard let model = showManager.model else { return cell }
        if (model.count > indexPath.section) {
            cell.configureCell(model: showManager.model?[indexPath.section].showList)
        }
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cellHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let numberOfSections = showManager.model?.count else { return 0 }
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let model = showManager.model else { return nil }
        if (model.count > section) {
            return model[section].category
        }
        return nil
    }
}


extension ViewController: CollectionTableViewCellDelegate {
    func onCellTap(show: MinimizedShow?) {
        let vc = ViewControllerFactory.viewController(for: .detailedShow) as! DetailedShowInfoViewController
        vc.configureViewController(show: show)
        present(vc, animated: true, completion: nil)
    }
}
