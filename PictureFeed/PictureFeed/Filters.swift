//
//  Filters.swift
//  PictureFeed
//
//  Created by Andy Malik on 2/16/16.
//  Copyright © 2016 Andy Malik. All rights reserved.
//

import UIKit

typealias FiltersCompletion = (theImage: UIImage?) -> ()

class Filters {
    
    // Hold On To Original Image
    
    private class func filter(name: String, image: UIImage, completion: FiltersCompletion) {
        
        /* MARK: Useful for many filters:
        let filterNames = CIFilter.filterNamesInCategory(kCICategoryBuiltIn) as [String]
        print(filterNames)
        */
        
        NSOperationQueue().addOperationWithBlock { () -> Void in
            
            guard let filter = CIFilter(name: name) else { fatalError("Filters Class - Filter Failed - Line 19 - Check Spelling, perhaps?") }
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            
            // GPU Context
            let options = [kCIContextWorkingColorSpace : NSNull()]
            let EAGContext = EAGLContext(API: .OpenGLES2)
            let GPUContext = CIContext(EAGLContext: EAGContext, options: options)
            
            // Get final image
            guard let outputImage = filter.outputImage else { fatalError("Filters Class - No Image - Line 29") }
            let CGImage = GPUContext.createCGImage(outputImage, fromRect: outputImage.extent)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                completion(theImage: UIImage(CGImage: CGImage))
            })
        }
    }
    
    class func monochrome(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectMono", image: image, completion: completion)
    }
}