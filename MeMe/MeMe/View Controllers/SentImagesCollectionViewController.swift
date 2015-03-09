//
// Created by Vlad Spreys on 8/03/15.
// Copyright (c) 2015 Spreys.com. All rights reserved.
//

import UIKit
import Foundation

class SentImagesCollectionViewController : UICollectionViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var memes : [Meme]!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as AppDelegate
        
        self.memes = appDelegate.memes
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCell", forIndexPath: indexPath) as SentMemesCollectionViewCell
        
        var meme = self.memes[indexPath.item]
        
        cell.imageView?.image = meme.memedImage
        
        return cell;
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
}
