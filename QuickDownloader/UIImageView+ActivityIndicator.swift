//
//  UIImageView+ActivityIndicator.swift
//  QuickDownloader
//
//  Created by Zaiyang Li on 24/07/2016.
//  Copyright © 2016 Zaiyang Li. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import SnapKit
extension UIImageView {
    func setImageURLWithIndicator(url: NSURL) -> Void {
        
        let imageManager = SDWebImageManager.sharedManager()
        if(imageManager.cachedImageExistsForURL(url)){
            self.sd_setImageWithURL(url)
        } else {
            let spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
            spinner.startAnimating()
            self.addSubview(spinner)
            spinner.snp.makeConstraints(closure: { (make) in
                make.centerX.equalTo(self.snp.centerX)
                make.centerY.equalTo(self.snp.centerY)
            })
            self.bringSubviewToFront(spinner)
            self.sd_setImageWithURL(
                url, completed: { (image: UIImage!, error: NSError!, cache: SDImageCacheType, url: NSURL!) in
                    UIView.animateWithDuration(0.32, animations: {
                            spinner.alpha = 0
                        },
                        completion: { (finished :Bool) in
                            spinner.removeFromSuperview()
                    })
            })
        }
    }
}