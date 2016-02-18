//
//  Post.swift
//  PictureFeed
//
//  Created by Andy Malik on 2/16/16.
//  Copyright © 2016 Andy Malik. All rights reserved.
//
//  Followed along with:
//  http://www.appcoda.com/cloudkit-introduction-tutorial/
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
            
            // Followed along a tutorial which used timestamps as a unique ID
            
            let timestampAsString = String(format: "%f", NSDate.timeIntervalSinceReferenceDate())
            // the %f is requesting that the conversion of the NSDate be in the format of a 64-bit float (double)
            let timestampParts = timestampAsString.componentsSeparatedByString(".")
            // Since it's a double, we'll get a chunk of numbers on both sides of the decimal point. 
            // We only really need the left side.
            
            let imageID = CKRecordID(recordName: timestampParts[0])
            // This saves a CKRecordID based on the number we have came up with earlier.
    
            let record = CKRecord(recordType: "Post", recordID: imageID)
            record.setObject(asset, forKey: "image")
            //record.setObject(String, forKey: "status")? MARK: Todo
            
            return record
            
        } else { throw PostError.CreatingCKRecord }
    }
    
}