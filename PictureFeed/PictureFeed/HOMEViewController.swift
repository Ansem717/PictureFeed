//
//  ViewController.swift
//  PictureFeed
//
//  Created by Andy Malik on 2/12/16.
//  Copyright © 2016 Andy Malik. All rights reserved.
//

import UIKit

class HOMEViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    @IBOutlet weak var imageView: UIImageView!
    
    var originalImage = Filters()
    
    lazy var UIIPC = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func presentImagePicker(sourceType: UIImagePickerControllerSourceType) {
        
        self.UIIPC.delegate = self
        self.UIIPC.sourceType = sourceType
        self.presentViewController(self.UIIPC, animated: true, completion: nil)
    }
    
    func presentActionSheet() {
        
        let actionSheet = UIAlertController(title: "Source", message: "Please select the source type.", preferredStyle: .ActionSheet)
        let camAct = UIAlertAction(title: "Camera", style: .Default) { (action) -> Void in
            self.presentImagePicker(.Camera)
        }
        let photoAct = UIAlertAction(title: "Photo", style: .Default) { (action) -> Void in
            self.presentImagePicker(.PhotoLibrary)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        actionSheet.addAction(camAct)
        actionSheet.addAction(photoAct)
        actionSheet.addAction(cancel)
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    
    //MARK: BUTTON FUNCTIONS
    @IBAction func addImages(sender: UIBarButtonItem) {
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            presentActionSheet()
        } else {
            self.presentImagePicker(.PhotoLibrary)
        }
    }
    
    @IBAction func editImage(sender: UIBarButtonItem) {
        
        guard let image = self.imageView.image else {
            let alert = UIAlertController(title: "Hold on!", message: "You have not selected an image!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            return
        }
        
        let actionSheet = UIAlertController(title: "Filters", message: "Please select a filter.", preferredStyle: .Alert)
        let bwAction = UIAlertAction(title: "Black and White", style: .Default) { (action) -> Void in
            Filters.monochrome(image, completion: { (theImage) -> () in
                self.imageView.image = theImage
            })
        }
        
        let resetAction = UIAlertAction(title: "Reset", style: .Destructive) { (action) -> Void in
            self.imageView.image = self.originalImage.image
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        actionSheet.addAction(bwAction)
        actionSheet.addAction(resetAction)
        actionSheet.addAction(cancel)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
        
    }
    
    @IBAction func saveImage(sender: UIBarButtonItem) {
        
        guard let image = self.imageView.image else {
            let alert = UIAlertController(title: "Hold on!", message: "You have not selected an image!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            return
        }
        
        if image == originalImage.image {
            let alert = UIAlertController(title: "Hold on!", message: "Are you sure you wish to save an identical image?", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Continue", style: .Default, handler: { (action) -> Void in
                self.proceedToSave(image)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            return
        }
        
        self.proceedToSave(image)
    }
    
    func proceedToSave(image: UIImage) {
        //Add prompt for status
        let status = "Check out my filters!"
        
        API.shared.POST(Post(image: image, status: status)) { (success) -> () in
            if success {
                 UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
            }
        }
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafePointer<Void>) {
        
        if error == nil {
            
            let alertController = UIAlertController(title: "Saved!", message: "Your image has been saved to your photos", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
}

extension HOMEViewController { //MARK: Delegate Functions

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageView.image = image
        originalImage = Filters(image: image)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}