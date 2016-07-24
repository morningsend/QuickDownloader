//
//  SecondViewController.swift
//  QuickDownloader
//
//  Created by Zaiyang Li on 22/07/2016.
//  Copyright © 2016 Zaiyang Li. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

@objc
protocol DownloadViewControllerDataSource {
    func numberOfFiles(controller: DownloadViewController) -> Int;
    func nameForFileAtIndex(index:Int) -> String;
    func urlForFileAtIndex(index: Int) -> NSURL;
}
@objc
protocol DownloadViewControllerDelegate {
    func didFinishDownloadFile(name: String, url: NSURL) -> Void;
    func didFailDownloadFile(name: String, url:NSURL) -> Void;
    func didStartDownloadFile(name: String, url: NSURL) -> Void;
}

class DownloadViewController : UITableViewController {

    
    var realmNotificationToken : NotificationToken? = nil
    var downloadImageList : Results<ImageListItem>? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "Download"
        downloadImageList = DownloadListDAO.sharedInstance.getAllImagesInList().sorted("id")
        realmNotificationToken = DownloadListDAO.sharedInstance.addNotificationToDownloadList({[weak self] (changes : RealmCollectionChange<List<ImageListItem>>) in
            guard let tableView = self?.tableView else {
                return
            }
            switch(changes){
            case .Initial:
                    break;
            case .Update(_, let deletions, let insertions, let modifications):
                print(deletions)
                print(insertions)
                print(modifications)
                if (self?.isViewLoaded())! && self?.view.window != nil {
                    
                } else {
                    self?.navigationController!.tabBarItem.badgeValue = "\((self?.downloadImageList?.count)!)"
                }
                let deletedIndexPaths = deletions.map({ (index) -> NSIndexPath in
                    return NSIndexPath(forRow: index, inSection: 0)
                })
                let insertedIndexPaths = insertions.map({ (index) -> NSIndexPath in
                    return NSIndexPath(forRow: index, inSection: 0)
                })
                let modifiedIndexPaths = modifications.map({ NSIndexPath(forRow:$0, inSection: 0) })
                tableView.beginUpdates()
                tableView.deleteRowsAtIndexPaths(deletedIndexPaths, withRowAnimation: .Automatic)
                tableView.insertRowsAtIndexPaths(insertedIndexPaths, withRowAnimation: .Automatic)
                tableView.reloadRowsAtIndexPaths(modifiedIndexPaths, withRowAnimation: .Automatic)
                tableView.endUpdates()
                    break;
            case .Error(let error):
                print(error)
                    break;
            }
        })
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.tabBarItem.badgeValue = nil
        if(numberOfSectionsInTableView(self.tableView) > 0){
            setClearAllBarItem()
            setDownloadAllBarItem()
        }
    }
    internal func setDownloadAllBarItem() {
        let downloadAllBarItem = UIBarButtonItem(title: "Download All", style: .Done, target: self, action: #selector(self.downloadAllPressed(_:)))
        self.navigationItem.leftBarButtonItem = downloadAllBarItem
    }
    internal func setClearAllBarItem(){
        let clearAllBarItem = UIBarButtonItem(title: "Clear List", style: UIBarButtonItemStyle.Plain , target: self, action: #selector(self.clearListPressed(_:)))
        self.navigationItem.rightBarButtonItem = clearAllBarItem
    }
    func clearListPressed(sender: UIBarButtonItem){
        DownloadListDAO.sharedInstance.clearList()
    }
    func downloadAllPressed(sender: UIBarButtonItem){
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func refreshDownloadList(){
        self.tableView.reloadData()
    }
    
    deinit {
        realmNotificationToken?.stop()
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DownloadListDAO.sharedInstance.getAllImagesInList().count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DownloadTableViewCell", forIndexPath: indexPath) as! DownloadTableViewCell
        let item = downloadImageList?[indexPath.row]
        cell.authorLabel.text = item!.author
        cell.thumbnailView.sd_setImageWithURL(NSURL(string: "https://unsplash.it/300/200?image=\(item!.id)"))
        cell.downloadProgress.progress = 0.0
        cell.selectionStyle = .None
        return cell
    }
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}

