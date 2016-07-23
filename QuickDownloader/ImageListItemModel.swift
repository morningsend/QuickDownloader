//
//  ImageListItemModel.swift
//  QuickDownloader
//
//  Created by Zaiyang Li on 22/07/2016.
//  Copyright © 2016 Zaiyang Li. All rights reserved.
//

import UIKit
import Mantle

class ImageListItemModel: MTLModel, MTLJSONSerializing {
    
    var format: String = ""
    var width: Int = 0
    var height: Int = 0
    var filename: String = ""
    var id : Int = 0
    var author: String = ""
    var authorURL : String = ""
    var postURL : String = ""
    
    static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return [
            "format":"format",
            "width" : "width",
            "height" : "height",
            "filename" : "filename",
            "id": "id",
            "author" : "author",
            "authorURL" : "author_url",
            "postURL" : "post_url"
        ]
    }
}
