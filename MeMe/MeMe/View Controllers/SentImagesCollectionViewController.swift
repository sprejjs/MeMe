//
// Created by Vlad Spreys on 8/03/15.
// Copyright (c) 2015 Spreys.com. All rights reserved.
//

import UIKit
import Foundation

class SentImagesCollectionViewController : UICollectionViewController {    
    var memes : [Meme]!
    
    @IBAction func newMeme(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Sent Memes"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        
        self.memes = appDelegate.memes
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCell", forIndexPath: indexPath) as! SentMemesCollectionViewCell
        
        let meme = self.memes[indexPath.item]
        
        cell.imageView?.image = meme.memedImage
        
        return cell;
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let detailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        
        //The line below is a hack to instantiate outlets. Without it imageView is nil.
        //Refer to http://stackoverflow.com/questions/12523198/storyboard-instantiateviewcontrollerwithidentifier-not-setting-iboutlets for details
        print(detailViewController.view)
        detailViewController.imageView.image = self.memes[indexPath.item].memedImage
        
        self.navigationController!.pushViewController(detailViewController, animated: true)
    }
}
