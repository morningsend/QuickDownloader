//
//  ImageListCell.swift
//  QuickDownloader
//
//  Created by Zaiyang Li on 22/07/2016.
//  Copyright © 2016 Zaiyang Li. All rights reserved.
//

import UIKit

class ImageListCell: UITableViewCell {
    
    @IBOutlet var thumbnailView: UIImageView!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var sizeLabel: UILabel!
    @IBOutlet var addButton: UIButton!
    
    var size : UILabel {
        get {
            return self.sizeLabel
        }
        set(newLabel){
            self.sizeLabel = newLabel
        }
    }
    
    var author : UILabel {
        get {
            return self.authorLabel
        }
        
        set(newLabel) {
            self.authorLabel = newLabel
        }
    }
    
    var thumbnail : UIImageView {
        get {
            return self.thumbnailView
        }
        set(newImageView){
            self.thumbnailView = newImageView
        }
    }
    var add: UIButton {
        get {
            return self.addButton
        }
        set(button){
            self.addButton = button
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Default, reuseIdentifier:reuseIdentifier)
        loadCellComponents()
    }
    init(){
        super.init(style:.Default, reuseIdentifier:"ImageListCell")
    }
    func loadCellComponents(){
        thumbnail = UIImageView()
        authorLabel = UILabel()
        sizeLabel = UILabel()
        addButton = UIButton()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
