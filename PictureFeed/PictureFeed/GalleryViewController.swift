//
//  GalleryViewController.swift
//  PictureFeed
//
//  Created by Andy Malik on 2/17/16.
//  Copyright © 2016 Andy Malik. All rights reserved.
//
//  DISCLAIMER:
//  I followed along the tutorial at
//  http://www.raywenderlich.com/78550/beginning-ios-collection-views-swift-part-1
//  http://www.appcoda.com/cloudkit-introduction-tutorial/
//


import UIKit
import CloudKit

class GalleryViewController: UICollectionViewController {

    @IBOutlet weak var galleryActivityIndicator: UIActivityIndicatorView!
    @IBOutlet var galleryView: UICollectionView!
    
    private let reuseID = "galleryCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImages()
    }
    
    var imagesArray: [CKRecord] = [] {
        didSet {
            self.galleryView.reloadData()
        }
    }
    
    func getImages() {
        galleryActivityIndicator.startAnimating()
        API.shared.GETall { (success, results) -> () in
            self.imagesArray = results!
        }
    }
    
}


extension GalleryViewController { //DATASOURCE
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = galleryView.dequeueReusableCellWithReuseIdentifier(reuseID, forIndexPath: indexPath) as! GalleryViewCell
        let imageRecord: CKRecord = imagesArray[indexPath.row]
        let thisImage = imageRecord.valueForKey("image") as! CKAsset
        
        if let data = NSData(contentsOfURL: thisImage.fileURL) {
            cell.imageView.image =  UIImage(data: data)
        }
        
        cell.backgroundColor = UIColor.grayColor() //Followed along with the tutorial. Also, if any images fail to load, they will be a grey block.
        
        galleryActivityIndicator.stopAnimating()
        return cell
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout { //DELEGATE-FLOW-LAYOUT
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return sectionInsets //Followed along with tutorial, I'd love to see how you all did it in class
    }
}





