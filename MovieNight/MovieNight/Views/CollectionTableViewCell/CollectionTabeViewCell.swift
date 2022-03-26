//
//  MovieTableViewCell.swift
//  MovieNight
//
//  Created by Aliaksandr Chekushkin on 3/23/22.
//

import UIKit

protocol CollectionTableViewCellDelegate {
    func onCellTap(show: MinimizedShow?)
}

class CollectionTabeViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model: [MinimizedShow]?
    var delegate: CollectionTableViewCellDelegate?
    private var show: MinimizedShow?
    
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
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(model: [MinimizedShow]?) {
        self.model = model
        collectionView.reloadData()
    }
    
}
extension CollectionTabeViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        
        let show = model?[indexPath.row]
        cell.configureCell(show: show)
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = 200
        let height: CGFloat = 300
        return CGSize(width: width, height: height)
    }
    
    
}

extension CollectionTabeViewCell: MovieCollectionViewCellDelegate {
    
    func onCellTap(show: MinimizedShow?) {
        self.show = show
        delegate?.onCellTap(show: show)
    }
}
