//
//  AlbumExtensions.swift
//  BlueLibrarySwift
//
//  Created by fanpeng on 17/3/27.
//  Copyright © 2017年 Raywenderlich. All rights reserved.
//

import Foundation

extension Album {
    func ae_tableRepresentation() -> (titles:[String], values:[String]) {
        return (["Artist", "Album", "Genre", "Year"], [artist, title, genre, year])
    }
}
