//
//  FirstViewController.swift
//  QuickDownloader
//
//  Created by Zaiyang Li on 22/07/2016.
//  Copyright © 2016 Zaiyang Li. All rights reserved.
//

import UIKit
import Alamofire
import Mantle
import SDWebImage
import RealmSwift

class ImageTableViewController : UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    
    var images : Results<ImageListItem>?
    var currentDetailImageId : Int = -1
    var detailViewController : ImageDetailViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull down to refresh")
        refreshControl.addTarget(self, action: #selector(ImageTableViewController.beginDownloadImageList), forControlEvents: .ValueChanged)
        self.refreshControl? = refreshControl
        self.navigationItem.title = "Unsplash.it"
        self.images = ImageDAO.sharedInstance.getAllImageItems()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func downloadImageList(){
        Alamofire
            .request(.GET, NSURL(string: "https://unsplash.it/list")!)
            .responseJSON { (response: Response<AnyObject, NSError>) in
                switch(response.result){
                case .Success(let json):
                    do {
                    //print(json)
                        let imageItemModels = try MTLJSONAdapter.modelsOfClass(ImageListItemModel.self,
                            fromJSONArray:json as! [AnyObject])
                        var items = [ImageListItem]()
                        for model in imageItemModels {
                            let item = ImageListItem.from(model as! ImageListItemModel)
                            items.append(item)
                        }
                        ImageDAO.sharedInstance.createOrUpdateImages(items)
                        dispatch_async(dispatch_get_main_queue()) { [weak self] in
                            self?.refreshControl?.endRefreshing()
                            self?.tableView.reloadData()
                        }
                    }
                    catch {
                        
                    }
                break
                case .Failure(let error):
                    print(error)
                    break;
                }
            }
    }
    func beginDownloadImageList(){
        NSLog("Downloading image data")
        
        downloadImageList()
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.images != nil) {
            return (self.images?.count)!
        } else {
            return 0
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = self.images?[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ImageListCell", forIndexPath: indexPath)
        
        if let imageCell = cell as? ImageListCell {
            let urlString = "https://unsplash.it/300/200?image=\(item!.id)"
            imageCell.thumbnailView.sd_setImageWithURL(NSURL(string: urlString))
            imageCell.author.text = item!.author
            imageCell.add .addTarget(self, action: #selector(self.addButtonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            imageCell.add.tag = item!.id
            if item?.downloaded.value == nil {
                imageCell.add.enabled = true
            } else {
                imageCell.add.enabled = !(item?.downloaded.value)!
            }
        }
        return cell;
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        detailViewController?.imageItemId = (images?[indexPath.row].id)!
    }
    func addButtonPressed(sender:UIButton)->(){
        print("button with tag: \(sender.tag) pressed")
        let imageItem = images?.filter(NSPredicate(format: "id == %d", sender.tag))
        if(imageItem?.count > 0) {
            DownloadListDAO.sharedInstance.insertImageIntoList(imageItem![0])
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == ImageDetailViewController.showDetailSegueId){
            detailViewController = segue.destinationViewController as? ImageDetailViewController
        }
    }
}

