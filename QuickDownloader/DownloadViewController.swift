//
//  SecondViewController.swift
//  QuickDownloader
//
//  Created by Zaiyang Li on 22/07/2016.
//  Copyright © 2016 Zaiyang Li. All rights reserved.
//

import UIKit

protocol DownloadViewControllerDataSource {
    func numberOfFiles(controller: DownloadViewController) -> Int;
    func nameForFileAtIndex(index:Int) -> String;
    func urlForFileAtIndex(index: Int) -> NSURL;
}

protocol DownloadViewControllerDelegate {
    func didFinishDownloadFile(name: String, url: NSURL) -> Void;
    func didFailDownloadFile(name: String, url:NSURL) -> Void;
    func didStartDownloadFile(name: String, url: NSURL) -> Void;
}

class DownloadViewController : UITableViewController {
    
    var datasource : DownloadViewControllerDataSource?
    var downloadDelegate: DownloadViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "Download Queue"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func refreshDownloadList(){
        self.tableView.reloadData()
    }
}

