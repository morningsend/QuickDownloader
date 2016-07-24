//
//  DownloadManager.swift
//  QuickDownloader
//
//  Created by Zaiyang Li on 24/07/2016.
//  Copyright © 2016 Zaiyang Li. All rights reserved.
//

import Foundation
import Alamofire

private let singletonInstance : DownloadManager = {
    let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
    let sessionDelegate = Manager.SessionDelegate()
    let manager = DownloadManager(configuration:configuration,
                                  delegate: sessionDelegate, serverTrustPolicyManager: nil)
    manager.startRequestsImmediately = false
    return manager;
}()

class DownloadManager : Manager {
    
    let defaultWidth = 1600
    let defaultHeight = 900
    let storageDirectory : NSURL = {
        let fileManager = NSFileManager.defaultManager()
        let cacheDirectory = fileManager.URLsForDirectory( .CachesDirectory, inDomains: .UserDomainMask)[0]
        let imageSavingPath = cacheDirectory
            .URLByAppendingPathComponent("unsplash.it")
        if(!fileManager.fileExistsAtPath(cacheDirectory.absoluteString)){
            try! fileManager.createDirectoryAtPath(cacheDirectory.absoluteString, withIntermediateDirectories: true, attributes: nil)
        }
        return imageSavingPath
    }()
    override init?(session: NSURLSession, delegate: Manager.SessionDelegate, serverTrustPolicyManager: ServerTrustPolicyManager?) {
        super.init(session: session, delegate: delegate, serverTrustPolicyManager: serverTrustPolicyManager)
    }
    override init(configuration: NSURLSessionConfiguration, delegate: Manager.SessionDelegate, serverTrustPolicyManager: ServerTrustPolicyManager?) {
        super.init(configuration: configuration, delegate: delegate, serverTrustPolicyManager: serverTrustPolicyManager)
    }
    init() {
        super.init()
    }
    class var sharedManager : DownloadManager {
        get {
            return singletonInstance
        }
    }
    lazy var downloadQueue : NSOperationQueue  = {
        let queue = NSOperationQueue()
        queue.maxConcurrentOperationCount = 3
        return queue;
    }()
    func queueImage(imageInfo: ImageListItem, completionHandler: ((image: ImageListItem)->Void)){
        queueImage(imageInfo, width: defaultWidth, height: defaultHeight, completionHandler: completionHandler)
    }
    func queueImage(imageInfo: ImageListItem, width: Int, height: Int, completionHandler: ((image: ImageListItem)->Void)){
        let url = urlForImage(imageInfo, width: width, height:height)
        let request = self.download(.GET, url) { [weak self] (url:NSURL, response: NSHTTPURLResponse) -> NSURL in
            return (self?.storageDirectory.URLByAppendingPathComponent(imageInfo.filename))!
        }
        let downloadOperation = ImageDownloadOperation(request: request, image: imageInfo)
        self.downloadQueue.addOperation(downloadOperation)
    }
    internal func urlForImage(image:ImageListItem, width: Int, height: Int) -> NSURL{
        return NSURL(string:"https://unsplash.it/\(width)/\(height)?image=\(image.id)")!
    }
}

