//
//  MovieCollectionViewCell.swift
//  MovieNight
//
//  Created by Aliaksandr Chekushkin on 3/23/22.
//

import UIKit

protocol MovieCollectionViewCellDelegate {
    func onCellTap(show: MinimizedShow?)
}

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    private var spinner = UIActivityIndicatorView()
    private var show: MinimizedShow?
    
    
    static let identifier = "MovieCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil)
    }
    
    var delegate: MovieCollectionViewCellDelegate?
    
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onCellTap))
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
        
    }
    
    @objc func onCellTap() {
        delegate?.onCellTap(show: show)
    }
    
    func configureCell(show: MinimizedShow?) {
        self.show = show
        
        spinner = UIActivityIndicatorView(frame: CGRect(x: bounds.origin.x,
                                                        y: bounds.origin.y,
                                                        width: bounds.width,
                                                        height: bounds.height))
        
        if show?.poster == nil {
            imageView.isHidden = true
            self.addSubview(spinner)
            spinner.startAnimating()
        } else {
            imageView.isHidden = false
            imageView.image = show?.poster
            spinner.stopAnimating()
        }
    }
}
