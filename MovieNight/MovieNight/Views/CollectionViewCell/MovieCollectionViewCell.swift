//
//  MovieCollectionViewCell.swift
//  MovieNight
//
//  Created by Aliaksandr Chekushkin on 3/23/22.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    
    private var spinner = UIActivityIndicatorView()
    
    static let identifier = "MovieCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: MovieCollectionViewCell.identifier,
                     bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.backgroundColor = .yellow
        
        imageView.layer.cornerRadius = 10
        let cgColor = CGColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        self.layer.shadowColor = cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowRadius = 5
        
        spinner = UIActivityIndicatorView(frame: CGRect(x: imageView.bounds.origin.x,
                                                            y: imageView.bounds.origin.y,
                                                            width: imageView.bounds.width,
                                                            height: imageView.bounds.height))
        imageView.addSubview(spinner)
            
    }
    
    func configureCell(title: String?, image: UIImage?) {
        spinner = UIActivityIndicatorView(frame: CGRect(x: bounds.origin.x,
                                                            y: bounds.origin.y,
                                                            width: bounds.width,
                                                            height: bounds.height))
        
        if image == nil {
            imageView.isHidden = true
            self.addSubview(spinner)
            spinner.startAnimating()
        } else {
            imageView.isHidden = false
            imageView.image = image
            spinner.stopAnimating()
        }
    }

}
