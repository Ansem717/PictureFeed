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
    
    func presentImagePicker(sourceType: UIImagePickerControllerSourceType)
    {
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
        //Edit
    }
    
    @IBAction func saveImage(sender: UIBarButtonItem) {
        //Save
    }
}

extension HOMEViewController //MARK: Delegate Functions
{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}