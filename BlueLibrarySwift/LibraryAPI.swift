//
//  LibraryAPI.swift
//  BlueLibrarySwift
//
//  Created by fanpeng on 17/3/27.
//  Copyright © 2017年 Raywenderlich. All rights reserved.
//

import UIKit

class LibraryAPI: NSObject {
   
    class var sharedInstance: LibraryAPI {
        struct Singleton {
            static let instance = LibraryAPI()
        }
        return Singleton.instance
    }
    
    private var persistencyManager: PersistencyManager
    private var httpClient: HTTPClient
    private var isOnlime: Bool
    
    override init() {
        persistencyManager = PersistencyManager()
        httpClient = HTTPClient()
        isOnlime = false
        
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(downloadeImage(notification:)), name: NSNotification.Name(rawValue: "BLDownloadImageNotification"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func saveAlbums() {
        persistencyManager.saveAlbums()
    }
    
    func downloadeImage(notification: Notification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        let imageView = userInfo["imageView"] as? UIImageView
        let coverUrl = userInfo["coverUrl"] as!  NSString
        
        if let imageViewUnWrapped = imageView {
            
            imageViewUnWrapped.image = persistencyManager.getImage(filename: coverUrl.lastPathComponent)
            if imageViewUnWrapped.image == nil {

                DispatchQueue.global().async {
                    // code
                    let dowanloadedImage = self.httpClient.downloadImage(coverUrl as String)
                    DispatchQueue.main.async {
                        // 主线程中
                        imageViewUnWrapped.image = dowanloadedImage
                        self.persistencyManager.saveImage(image: dowanloadedImage, filename: coverUrl.lastPathComponent)
                    }
                }
            }
            
            
        }
        
        
    }
    
   
    
   
    func getAlums() -> [Album] {
        return persistencyManager.getAlbums()
    }
    
    func addAlbum(album: Album, index: Int) {
        persistencyManager.addAlbum(album: album, index: index)
        if isOnlime {
            httpClient.postRequest("/api/addAlbum", body: album.descriptionAlbum())
        }
    }
    
    func deleteAlbum(index: Int) {
        persistencyManager.deleteAlbumAtIndex(index: index)
        if isOnlime {
            httpClient.postRequest("/api/deleteAlbum", body: "\(index)")
        }
    }

}

