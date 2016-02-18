//
//  GalleryViewCell.swift
//  PictureFeed
//
//  Created by Andy Malik on 2/17/16.
//  Copyright © 2016 Andy Malik. All rights reserved.
//

import UIKit

class GalleryViewCell: UICollectionViewCell {

    
    @IBOutlet weak var imageView: UIImageView!
    
}

// One of the tutorials talked about creating a custom cell, with an outlet for a UIImageView. 
// The cell inherits from all things that UICollectionViewCell has, so it's not going to interrupt
// or change anything. Infact, this class only adds an image outlet. That's it. 

