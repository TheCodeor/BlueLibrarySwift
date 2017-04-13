//
//  AlbumView.swift
//  BlueLibrarySwift
//
//  Created by fanpeng on 17/3/27.
//  Copyright © 2017年 Raywenderlich. All rights reserved.
//

import UIKit

class AlbumView: UIView {

    private var coverImage: UIImageView!
    private var indicator: UIActivityIndicatorView!
    private var didHighlightView: Bool!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, albumCover: String) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.black
        coverImage = UIImageView(frame: CGRect(x: 5, y: 5, width: frame.size.width - 10, height: frame.size.height - 10))
        addSubview(coverImage)
        
        indicator = UIActivityIndicatorView()
        indicator.center = center
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.startAnimating()
        addSubview(indicator)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "BLDownloadImageNotification"), object: self, userInfo: ["imageView":coverImage, "coverUrl" : albumCover])
        coverImage.addObserver(self, forKeyPath: "image", options: .initial, context: nil)
        
    }
    
    deinit {
        coverImage.removeObserver(self, forKeyPath: "image")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "image" {
            indicator.stopAnimating()
        }
    }
    
    func highlightAlbum(didHighlightView: Bool) {
        self.didHighlightView = didHighlightView
        if didHighlightView == true {
            backgroundColor = UIColor.white
        } else {
            backgroundColor = UIColor.black
        }
    }
 
}
