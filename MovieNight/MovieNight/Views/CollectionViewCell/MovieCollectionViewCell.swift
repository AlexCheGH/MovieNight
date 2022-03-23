//
//  MovieCollectionViewCell.swift
//  MovieNight
//
//  Created by Aliaksandr Chekushkin on 3/23/22.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    
    
    static let identifier = "MovieCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: MovieCollectionViewCell.identifier,
                     bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .yellow
        self.layer.cornerRadius = 5
    }
    
    func configureCell(title: String?, image: UIImage?) {
        label.text = title
        imageView.image = image
    }

}
