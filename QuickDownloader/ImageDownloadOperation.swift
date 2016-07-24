//
//  ImageDownloadOperation.swift
//  QuickDownloader
//
//  Created by Zaiyang Li on 24/07/2016.
//  Copyright © 2016 Zaiyang Li. All rights reserved.
//

import Foundation
import Alamofire

class ImageDownloadOperation : NSOperation {
    private var request : Request?
    private var image: ImageListItem?
    override init() {
        super.init()
    }
    convenience init(request: Request, image: ImageListItem){
        self.init()
        self.request? = request
        self.image? = image
    }
    override var asynchronous: Bool {
        get {
            return true
        }
    }
    override var cancelled: Bool {
        get {
            return false
        }
    }
    override var finished: Bool {
        get {
            return false
        }
    }
    override var executing: Bool {
        get {
            return false
        }
    }
    override func start() {
        
    }
    override func cancel() {
        
    }
}