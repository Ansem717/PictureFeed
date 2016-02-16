//
//  Post.swift
//  PictureFeed
//
//  Created by Andy Malik on 2/16/16.
//  Copyright © 2016 Andy Malik. All rights reserved.
//

import UIKit
import CloudKit

enum PostError: ErrorType {
    
    case WritingImage
    case CreatingCKRecord
}

class Post {
    
    let image: UIImage
    let status: String?
    
    init(image: UIImage, status: String? = "") {
        self.image = image
        self.status = status
    }
    
}

extension Post {
    
    class func recordWith(post: Post) throws -> CKRecord? {
        
        let imageURL = NSURL.imageURL()
        guard let imgData = UIImageJPEGRepresentation(post.image, 0.7) else { throw PostError.WritingImage }
        let saved = imgData.writeToURL(imageURL, atomically: true)
        if saved {
            let asset = CKAsset(fileURL: imageURL)
            let record = CKRecord(recordType: "Post")
            record.setObject(asset, forKey: "image")
            
            return record
            
        } else { throw PostError.CreatingCKRecord }
        
    }
}