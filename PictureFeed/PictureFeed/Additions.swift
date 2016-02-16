//
//  Additions.swift
//  PictureFeed
//
//  Created by Andy Malik on 2/16/16.
//  Copyright © 2016 Andy Malik. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func resize(image: UIImage, size: CGSize) -> UIImage { //MARK: Throw an error
        
        UIGraphicsBeginImageContext(size)
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        image.drawInRect(rect)
        
        defer { UIGraphicsEndImageContext() }
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
}

extension NSURL {
    
    class func imageURL() -> NSURL {
        guard let documentsDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first else { fatalError() }
        return documentsDirectory
    }
    
}