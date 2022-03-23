//
//  MovieTableViewCell.swift
//  MovieNight
//
//  Created by Aliaksandr Chekushkin on 3/23/22.
//

import UIKit

class CollectionTabeViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model: [MinimizedShow]? = [MinimizedShow]()
    
    static let identifier = "CollectionTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: CollectionTabeViewCell.identifier,
                     bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(MovieCollectionViewCell.nib(), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
extension CollectionTabeViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        
        let title = model?[indexPath.row].title
        let image = model?[indexPath.row].poster
        cell.configureCell(title: title, image: image)
        
        
        return cell
    }
    
}
