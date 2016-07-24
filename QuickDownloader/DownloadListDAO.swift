//
//  DownloadList.swift
//  QuickDownloader
//
//  Created by Zaiyang Li on 24/07/2016.
//  Copyright © 2016 Zaiyang Li. All rights reserved.
//

import Foundation
import RealmSwift

class DownloadListDAO : NSObject {
    static let sharedInstance = DownloadListDAO()
    
    var realm: Realm?
    
    internal let id = 1
    
    var downloadList : ImageDownloadList?
    
    internal required override init(){
        super.init()
        let config = Realm.Configuration.defaultConfiguration
        realm = try! Realm(configuration: config)
        loadList()
    }
    internal func loadList(){
        downloadList = realm?.objectForPrimaryKey(ImageDownloadList.self, key: NSNumber(integer: id))
        if downloadList == nil {
            downloadList = ImageDownloadList()
            downloadList!.id = self.id
            try! realm?.write({
                realm?.add(downloadList!)
            })
        }
    }
    func insertImageIntoList(image: ImageListItem){
        downloadList = realm?.objectForPrimaryKey(ImageDownloadList.self, key: id)
        try! realm?.write({
            let index = downloadList?.images.indexOf(image)
            if index == nil {
                downloadList?.images.append(image)
            }
        })
    }
    func removeImageFromList(image: ImageListItem){
        downloadList = realm?.objectForPrimaryKey(ImageDownloadList.self, key: id)
        try! realm?.write({
            let index = downloadList?.images.indexOf(image)
            if index != nil {
                downloadList?.images.removeAtIndex(index!)
            }
        })
    }
    func removeImageFromListById(id: Int){
        downloadList = realm?.objectForPrimaryKey(ImageDownloadList.self, key: id)
        try! realm?.write({ 
            let index = downloadList?.images.indexOf(NSPredicate(format: "id == %d", id))
            if index != nil {
                downloadList?.images.removeAtIndex(index!)
            }
        })
    }
    func addNotificationToDownloadList(block: (RealmCollectionChange<List<ImageListItem>>) -> ()) -> NotificationToken {
        downloadList = realm?.objectForPrimaryKey(ImageDownloadList.self, key: id)
        return (downloadList?.images.addNotificationBlock(block))!
    }
    func getAllImagesInList() -> List<ImageListItem> {
        downloadList = realm?.objectForPrimaryKey(ImageDownloadList.self, key: id)
        return (downloadList?.images)!
    }
    func clearList(){
        downloadList = realm?.objectForPrimaryKey(ImageDownloadList.self, key: id)
        try! realm?.write({ 
            downloadList?.images.removeAll()
        })
    }
}