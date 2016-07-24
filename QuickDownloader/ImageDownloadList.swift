//
//  ImageDownloadList.swift
//  QuickDownloader
//
//  Created by Zaiyang Li on 24/07/2016.
//  Copyright © 2016 Zaiyang Li. All rights reserved.
//

import Foundation
import RealmSwift

class ImageDownloadList : Object {
    let images = List<ImageListItem>()
    var id: Int = 0

    override class func primaryKey() -> String? {
        return "id"
    }
}