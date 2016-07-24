//
//  ImageDetailViewController.swift
//  QuickDownloader
//
//  Created by Zaiyang Li on 24/07/2016.
//  Copyright © 2016 Zaiyang Li. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {

    var addButton : UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(addButton == nil){
            addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(self.addButtonPressed(_:)))
            self.navigationItem.rightBarButtonItem = addButton
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addButtonPressed(sender:UIButton){
        
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
