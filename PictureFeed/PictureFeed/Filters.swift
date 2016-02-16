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
    
    var image: UIImage?
    
    init(image: UIImage? = nil) {
        self.image = image
    }
    
    private class func filter(name: String, image: UIImage, completion: FiltersCompletion) {
        
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
    class func crystalize(image: UIImage, completion: FiltersCompletion) {
        self.filter("CICrystallize", image: image, completion: completion)
    }
    class func sepia(image: UIImage, completion: FiltersCompletion) {
        self.filter("CISepiaTone", image: image, completion: completion)
    }
    class func bumpDistortion(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIBumpDistortion", image: image, completion: completion)
    }
    class func colorPosterize(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIColorPosterize", image: image, completion: completion)
    }
    
}






