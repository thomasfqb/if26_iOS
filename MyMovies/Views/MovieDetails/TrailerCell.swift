//
//  TrailerCell.swift
//  MyMovies
//
//  Created by Thomas Fauquemberg on 10/11/2019.
//  Copyright © 2019 Thomas Fauquemberg. All rights reserved.
//

import UIKit
import WebKit

class TrailerCell: BaseCell, WKNavigationDelegate {
    
    let youtubeView = WKWebView()
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    var videoId: String? {
        didSet {
            guard let id = videoId else { return }
            loadVideo(with: id)
        }
    }
    
    fileprivate func loadVideo(with id: String) {
        guard let url = URL(string: "https://www.youtube.com/embed/\(id)") else { return }
        youtubeView.load(URLRequest(url: url))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let color = UIColor.white.withAlphaComponent(0.07)
        backgroundColor = color
        backgroundView?.backgroundColor = color
        youtubeView.backgroundColor = color
        activityIndicator.color = .white
        youtubeView.alpha = 0
        
        clipsToBounds = true
        
        youtubeView.navigationDelegate = self
        setupLayout()
 
        
    }
    
    fileprivate func setupLayout() {
        addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
        activityIndicator.startAnimating()
        
        addSubview(youtubeView)
        youtubeView.fillSuperview()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //activityIndicator.stopAnimating()
        UIView.animate(withDuration: 1) {
            self.youtubeView.alpha = 1
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
