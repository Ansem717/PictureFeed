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
    
    static let shared = Filters()
    
    let context: CIContext
    
    private init() {
        let options = [kCIContextWorkingColorSpace : NSNull()]
        let EAGContext = EAGLContext(API: .OpenGLES2)
        self.context = CIContext(EAGLContext: EAGContext, options: options)
    }
    

    
    private func filter(name: String, image: UIImage, completion: FiltersCompletion) {
        
        NSOperationQueue().addOperationWithBlock { () -> Void in
            
            guard let filter = CIFilter(name: name) else { fatalError("Filters Class - Filter Failed - Line 19 - Check Spelling, perhaps?") }
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            
            
            
            // Get final image
            guard let outputImage = filter.outputImage else { fatalError("Filters Class - No Image - Line 29") }
            let CGImage = self.context.createCGImage(outputImage, fromRect: outputImage.extent)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                completion(theImage: UIImage(CGImage: CGImage))
            })
        }
    }
    
    func monochrome(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectMono", image: image, completion: completion)
    }
    func crystalize(image: UIImage, completion: FiltersCompletion) {
        self.filter("CICrystallize", image: image, completion: completion)
    }
    func sepia(image: UIImage, completion: FiltersCompletion) {
        self.filter("CISepiaTone", image: image, completion: completion)
    }
    func bumpDistortion(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIBumpDistortion", image: image, completion: completion)
    }
    func colorPosterize(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIColorPosterize", image: image, completion: completion)
    }
    
}






