//
//  ImageDAO.swift
//  QuickDownloader
//
//  Created by Zaiyang Li on 24/07/2016.
//  Copyright © 2016 Zaiyang Li. All rights reserved.
//

import RealmSwift

class ImageDAO: NSObject {
    static let sharedInstance = ImageDAO()
    var realm : Realm?
    internal required override init(){
        super.init()
        var config = Realm.Configuration()
        config.fileURL = config.fileURL?.URLByDeletingLastPathComponent?.URLByAppendingPathComponent("images.realm")
        realm = try! Realm(configuration: config)
    }
    
    func getImageWithId(id: Int) -> ImageListItem? {
        return realm?.objectForPrimaryKey(ImageListItem.self , key:id )
    }
    func createOrUpdateImage(image: ImageListItem) -> Void {
        try! realm?.write({ 
            realm!.add(image, update: true)
        })
    }
    func updateImageWithBlock(imageItem: ImageListItem, @noescape block: ((image:ImageListItem) throws -> Void)){
        try! realm?.write({
            try! block(image: imageItem)
        })
    }
    func createOrUpdateImages(images: [ImageListItem]) -> Void {
        try! realm?.write({
            for imageItem in images {
                realm!.add(imageItem, update: true)
            }
        })
    }
    func getAllImageItems()->Results<ImageListItem> {
        return (realm?.objects(ImageListItem.self))!
    }
}
