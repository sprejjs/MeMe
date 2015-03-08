//
// Created by Vlad Spreys on 8/03/15.
// Copyright (c) 2015 Spreys.com. All rights reserved.
//

import UIKit
import Foundation

class Meme {
    var topCaption: String?
    var bottomCaption: String?
    var originalImage: UIImage
    var memedImage: UIImage
    
    init(topCaption: String, bottomCaption: String, originalImage: UIImage, memedImage: UIImage){
        self.topCaption = topCaption
        self.bottomCaption = bottomCaption
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
}
