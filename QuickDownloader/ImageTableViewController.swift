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

class ImageTableViewController : UITableViewController, UISearchBarDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    
    var imageItems : [ImageListItemModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull down to refresh")
        refreshControl.addTarget(self, action: #selector(ImageTableViewController.beginDownloadImageList), forControlEvents: .ValueChanged)
        self.refreshControl? = refreshControl
        self.navigationItem.title = "Unsplash.it"
        self.searchDisplayController?.searchResultsTableView.registerClass(ImageListCell.self, forCellReuseIdentifier: "ImageListCell")
        
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
                    let imageItemModels = try MTLJSONAdapter.modelsOfClass(ImageListItemModel.self, fromJSONArray:json as! [AnyObject])
                        dispatch_async(dispatch_get_main_queue()) { [weak self] in
                            self?.refreshControl?.endRefreshing()
                            self?.imageItems = imageItemModels as! [ImageListItemModel]
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
        return self.imageItems.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = imageItems[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ImageListCell", forIndexPath: indexPath)
        
        if let imageCell = cell as? ImageListCell {
            let urlString = "https://unsplash.it/300/200?image=\(item.id)"
            imageCell.thumbnailView.sd_setImageWithURL(NSURL(string: urlString))
            imageCell.author.text = item.author
            imageCell.add .addTarget(self, action: #selector(self.addButtonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            imageCell.add.tag = item.id
        }
        return cell;
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.reloadData()
    }
    func addButtonPressed(sender:UIButton)->(){
        print("button with tag: \(sender.tag) pressed")
    }
}

