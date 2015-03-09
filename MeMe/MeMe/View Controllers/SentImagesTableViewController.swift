//
//  SentImagesTableViewController.swift
//  MeMe
//
//  Created by Vlad Spreys on 8/03/15.
//  Copyright (c) 2015 Spreys.com. All rights reserved.
//

import Foundation
import UIKit

class SentImagesTableViewController : UITableViewController {
    var memes : [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.title = "Sent Memes"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as AppDelegate
        
        self.memes = appDelegate.memes
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("MemeCell") as UITableViewCell
        
        var meme = self.memes[indexPath.item]
        
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = meme.topCaption
        cell.detailTextLabel?.text = meme.bottomCaption
        
        return cell;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var detailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as MemeDetailViewController
        
        //The line below is a hack to instantiate outlets. Without it imageView is nil.
        //Refer to http://stackoverflow.com/questions/12523198/storyboard-instantiateviewcontrollerwithidentifier-not-setting-iboutlets for details
        print(detailViewController.view)
        detailViewController.imageView.image = self.memes[indexPath.item].memedImage
        
        self.navigationController!.pushViewController(detailViewController, animated: true)
    }
    
}