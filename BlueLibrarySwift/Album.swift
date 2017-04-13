//
//  Album.swift
//  BlueLibrarySwift
//
//  Created by fanpeng on 17/3/27.
//  Copyright © 2017年 Raywenderlich. All rights reserved.
//

import UIKit

class Album: NSObject, NSCoding {
    
    var title: String!
    var artist: String!
    var genre: String!
    var coverUrl: String!
    var year: String!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        self.title = aDecoder.decodeObject(forKey: "title") as? String
        self.artist = aDecoder.decodeObject(forKey: "artist") as? String
        self.genre = aDecoder.decodeObject(forKey: "genre") as? String
        self.coverUrl = aDecoder.decodeObject(forKey: "cover_url") as? String
        self.year = aDecoder.decodeObject(forKey: "year") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(artist, forKey: "artist")
        aCoder.encode(genre, forKey: "genre")
        aCoder.encode(coverUrl, forKey: "cover_url")
        aCoder.encode(year, forKey: "year")
    }
    
    
    init(title: String, artist: String, genre: String, coverUrl: String, year: String) {
        super.init()
        
        self.title = title
        self.artist = artist
        self.genre = genre
        self.coverUrl = coverUrl
        self.year = year
    }
    
    func descriptionAlbum() -> String {
        return "title:\(title)" +
        "artise:\(artist)" +
        "genre:\(coverUrl)" +
        "year:\(year)"
    }
}
