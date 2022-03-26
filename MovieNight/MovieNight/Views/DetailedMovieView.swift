//
//  WebView.swift
//  MovieNight
//
//  Created by Aliaksandr Chekushkin on 3/25/22.
//

import UIKit
import WebKit

class DetailedMovieView: UIView {
    
    @IBOutlet weak var webKitView: WKWebView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var aboutTitle: UILabel!
    @IBOutlet weak var descriptionField: UITextView!
    
    private var model: MinimizedShow?
//    private var youTubeLink: String = ""
    
    func configureView(model: MinimizedShow?, youTubeLink: String) {
        self.model = model
        
        configureWebView(link: youTubeLink)
        configureImageView(image: model?.poster)
        configureTitle(text: model?.title)
        configureAboutLabel()
        configureTextField(text: model?.description)
    }
    
    private func configureWebView(link: String) {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        
        DispatchQueue.main.async {
            
            guard let videoURL = URL(string: link) else { return }
            let request = URLRequest(url: videoURL)
            self.webKitView.load(request)
        }
    }
    
    private func configureImageView(image: UIImage?) {
        imageView.image = image
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = imageView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.addSubview(blurEffectView)
    }
    
    private func configureTitle(text: String?) {
        title.text = text ?? "N/A"
    }
    
    private func configureAboutLabel() {
        aboutTitle.text = "About"
    }
    
    private func configureTextField(text: String?) {
        descriptionField.text = text ?? "N/A"
    }
    
    static func loadViewFromNib() -> DetailedMovieView {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "DetailedMovieView", bundle: bundle) //“MyViews” is name of xib file
        return nib.instantiate(withOwner: nil, options: nil).first as! DetailedMovieView 
    }
    
}
