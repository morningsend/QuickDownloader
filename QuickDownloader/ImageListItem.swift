//
//  ImageListItem.swift
//  QuickDownloader
//
//  Created by Zaiyang Li on 22/07/2016.
//  Copyright © 2016 Zaiyang Li. All rights reserved.
//

import Foundation
import RealmSwift

class ImageListItem: Object {

    dynamic var format: String = ""
    dynamic var width: Int = 0
    dynamic var height: Int = 0
    dynamic var filename: String = ""
    dynamic var id : Int = 0
    dynamic var author: String = ""
    dynamic var authorURL : String = ""
    dynamic var postURL : String = ""

}

extension ImageListItem {
    static func from(model:ImageListItemModel) -> ImageListItem{
        let item = ImageListItem()
        item.format = model.format
        item.width = model.width
        item.height = model.height
        item.filename = model.filename
        item.id = model.id
        item.author = model.author
        item.authorURL = model.authorURL
        item.postURL = model.postURL
        return item
    }
}
