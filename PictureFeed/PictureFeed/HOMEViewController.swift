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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var sideMenuLeadingConstraint: NSLayoutConstraint!
    
    var originalImage = Filters()
    
    lazy var UIIPC = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuLeadingConstraint.constant = 60.0
        self.view.layoutIfNeeded()
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
        
        let popUp = UIAlertController(title: "Source", message: "Please select the source type.", preferredStyle: .ActionSheet)
        
        popUp.addAction(UIAlertAction(title: "Camera", style: .Default) { (action) -> Void in
            self.presentImagePicker(.Camera)
            })
        popUp.addAction(UIAlertAction(title: "Photo", style: .Default) { (action) -> Void in
            self.presentImagePicker(.PhotoLibrary)
            })
        popUp.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(popUp, animated: true, completion: nil)
    }
    
    
    //MARK: BUTTON FUNCTIONS
    
    
    @IBAction func menuButton(sender: AnyObject) {
        toggleSideBar()
    }
    
    @IBAction func addImageSidebarButton(sender: UIButton) {
        toggleSideBar()
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            presentActionSheet()
        } else {
            self.presentImagePicker(.PhotoLibrary)
        }
        
    }
    
    
    @IBAction func editImageSidebarButton(sender: AnyObject) {
        toggleSideBar()
        
        guard let image = self.imageView.image else {
            let popUp = UIAlertController(title: "Hold on!", message: "You have not selected an image!", preferredStyle: .Alert)
            
            popUp.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
            
            self.presentViewController(popUp, animated: true, completion: nil)
            
            return
        }
        
        let popUp = UIAlertController(title: "Filters", message: "Please select a filter.", preferredStyle: .Alert)
        
        //MARK: Possible to refractor with loop, maybe?
        popUp.addAction(UIAlertAction(title: "Black and White", style: .Default) { (action) -> Void in
            self.activityIndicator.startAnimating()
            self.imageView.alpha = 0.5
            Filters.monochrome(image, completion: { (theImage) -> () in
                self.imageView.image = theImage
                self.activityIndicator.stopAnimating()
                self.imageView.alpha = 1.0
            })
        })
        popUp.addAction(UIAlertAction(title: "Crystalize", style: .Default) { (action) -> Void in
            self.activityIndicator.startAnimating()
            self.imageView.alpha = 0.5
            Filters.crystalize(image, completion: { (theImage) -> () in
                self.imageView.image = theImage
                self.activityIndicator.stopAnimating()
                self.imageView.alpha = 1.0
            })
        })
        popUp.addAction(UIAlertAction(title: "Sepia", style: .Default) { (action) -> Void in
            self.activityIndicator.startAnimating()
            self.imageView.alpha = 0.5
            Filters.sepia(image, completion: { (theImage) -> () in
                self.imageView.image = theImage
                self.activityIndicator.stopAnimating()
                self.imageView.alpha = 1.0
            })
        })
        popUp.addAction(UIAlertAction(title: "Bump Distortion", style: .Default) { (action) -> Void in
            self.activityIndicator.startAnimating()
            self.imageView.alpha = 0.5
            Filters.bumpDistortion(image, completion: { (theImage) -> () in
                self.imageView.image = theImage
                self.activityIndicator.stopAnimating()
                self.imageView.alpha = 1.0
            })
        })
        popUp.addAction(UIAlertAction(title: "Color Posterize", style: .Default) { (action) -> Void in
            self.activityIndicator.startAnimating()
            self.imageView.alpha = 0.5
            Filters.colorPosterize(image, completion: { (theImage) -> () in
                self.imageView.image = theImage
                self.activityIndicator.stopAnimating()
                self.imageView.alpha = 1.0
            })
        })
        
        popUp.addAction(UIAlertAction(title: "Reset", style: .Destructive) { (action) -> Void in
            self.imageView.image = self.originalImage.image
        })
        
        popUp.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(popUp, animated: true, completion: nil)
    }
    
    
    @IBAction func saveImageSidebarButton(sender: AnyObject) {
        toggleSideBar()
        
        guard let image = self.imageView.image else {
            let popUp = UIAlertController(title: "Hold on!", message: "You have not selected an image!", preferredStyle: .Alert)
            popUp.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
            
            self.presentViewController(popUp, animated: true, completion: nil)
            
            return
        }
        
        if image == originalImage.image {
            let popUp = UIAlertController(title: "Hold on!", message: "Are you sure you wish to save an identical image?", preferredStyle: .Alert)
            
            popUp.addAction(UIAlertAction(title: "Continue", style: .Default) { (action) -> Void in
                self.proceedToSave(image)
                })
            popUp.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
            
            self.presentViewController(popUp, animated: true, completion: nil)
            
            return
        }
        
        self.proceedToSave(image)
    }
    
    func proceedToSave(image: UIImage) {
        //MARK: Add prompt for status
        let status = "Check out my filters!"
        self.activityIndicator.startAnimating()
        self.imageView.alpha = 0.5
        
        API.shared.POST(Post(image: image, status: status)) { (success) -> () in
            if success {
                UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
            }
        }
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafePointer<Void>) {
        self.activityIndicator.stopAnimating()
        self.imageView.alpha = 1.0
        if error == nil {
            
            let popUp = UIAlertController(title: "Saved!", message: "Your image has been saved to your photos", preferredStyle: .Alert)
            
            popUp.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            
            self.presentViewController(popUp, animated: true, completion: nil)
        }
        print("Line 201 HOMEViewController ERROR - \(error)")
    }
    
    func toggleSideBar() {
        if sideMenuLeadingConstraint.constant == 60.0 {
            sideMenuLeadingConstraint.constant = -45.0
            UIView.animateWithDuration(0.5) {
                self.view.layoutIfNeeded()
            }
        } else {
            sideMenuLeadingConstraint.constant = 60.0
            UIView.animateWithDuration(0.5) {
                self.view.layoutIfNeeded()
            }
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