//
//  DownloadListCell.swift
//  QuickDownloader
//
//  Created by Zaiyang Li on 24/07/2016.
//  Copyright © 2016 Zaiyang Li. All rights reserved.
//

import Foundation
import UIKit

class DownloadTableViewCell : UITableViewCell{
    
    @IBOutlet var downloadProgress: UIProgressView!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var thumbnailView: UIImageView!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Default, reuseIdentifier: "DownloadTableViewCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}