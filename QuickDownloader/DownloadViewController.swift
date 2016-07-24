//
//  SecondViewController.swift
//  QuickDownloader
//
//  Created by Zaiyang Li on 22/07/2016.
//  Copyright © 2016 Zaiyang Li. All rights reserved.
//

import UIKit
import RealmSwift
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

@objc @IBDesignable
class DownloadViewController : UITableViewController {
    
    @IBOutlet var downloadDataSource : DownloadViewControllerDataSource?
    @IBOutlet var downloadDelegate: DownloadViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "Download"
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.tabBarItem.badgeValue = nil
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func refreshDownloadList(){
        self.tableView.reloadData()
        let numberOfFiles = downloadDataSource?.numberOfFiles(self)
        let badge: String? = numberOfFiles > 0 ? "\(numberOfFiles)" : nil
        self.navigationController?.tabBarItem.badgeValue = badge
    }
}

