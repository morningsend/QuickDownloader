//
//  ImageDetailViewController.swift
//  QuickDownloader
//
//  Created by Zaiyang Li on 24/07/2016.
//  Copyright © 2016 Zaiyang Li. All rights reserved.
//

import UIKit
protocol ImageDetailDataSource {
    
}


class ImageDetailViewController: UIViewController {
    
    static let showDetailSegueId = "ImageDetailViewSegue"
    var addButton : UIBarButtonItem?
    var image: ImageListItem?
    
    var imageItemIdValue: Int = -1
    
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    var imageItemId: Int {
        get {
            return imageItemIdValue
        }
        set(id) {
            imageItemIdValue = id
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if image == nil {
            image = ImageDAO.sharedInstance.getImageWithId(self.imageItemId)
        }
        imageView.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setupViewWithImageItem(image)
    }
    internal func setupViewWithImageItem(image: ImageListItem?){
        if image != nil {
            let url = NSURL(string: "https://unsplash.it/800/450?image=\(image!.id)")
            imageView.setImageURLWithIndicator(url!)
            authorLabel.text = "Photo taken by \((image?.author)!)"
            setupRightNavigationItem(image)
        }
    }

    internal func setupRightNavigationItem(image: ImageListItem?){
        if image != nil && image?.downloaded.value != nil{
            if(!(image?.downloaded.value)!) {
                addButton = UIBarButtonItem(barButtonSystemItem: .Add,
                                            target: self,
                                            action: #selector(self.addButtonPressed(_:)))
                self.navigationItem.rightBarButtonItem = addButton
            } else {
                self.navigationItem.rightBarButtonItem = nil;
            }
            
        } else {
            self.navigationItem.rightBarButtonItem = nil;
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addButtonPressed(sender:UIButton){
        sender.enabled = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
