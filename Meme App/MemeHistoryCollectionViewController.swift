//
//  CollectionViewController.swift
//  Meme App
//
//  Created by Abdallah Haji on 2015-08-03.
//  Copyright (c) 2015 Abdallah Haji. All rights reserved.
//

import Foundation

import UIKit

class MemeHistoryCollectionViewController: UIViewController, UICollectionViewDataSource {
    
    // Get ahold of some villains, for the table
    // This is an array of Villain instances
   var history: [MemeInstance] = []
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // MARK: Table View Data Source
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = false
       
    }
    

    
    override func viewDidLoad() {
         self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addNewMeme")
        
        let space: CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
        

    }
    
    func addNewMeme() {

        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        detailController.history = self.history
        self.navigationController?.pushViewController(detailController, animated: true)
  
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.history.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeHistoryCollectionViewCell", forIndexPath: indexPath) as! MemeHistoryCollectionViewCell
        
       let memeInstance = self.history[indexPath.row]
        
        // Set the name and image
        cell.memeLabel1.text = memeInstance.memeTextField1! as String
        //cell.memeImageView?.image = memeInstance.memeImage!
        
        let imageView = UIImageView(image: memeInstance.memeImageWithText!)
        cell.backgroundView = imageView
        
        //cell.memeImageView?.image = memeInstance.memeImageWithText!
        cell.memeLabel2.text = memeInstance.memeTextField1! as String
        
        
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeHistoryDetailViewController") as! MemeHistoryDetailViewController
        detailController.memeInstance = self.history[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
}















        //self.tabBarController?.viewControllers[0]


// self.presentViewController(detailController, animated: true, completion: nil)

//    }



//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add New Meme", style: .Plain, target: self, action: "addNewMeme")



//         self.presentViewController(detailController, animated: true, completion: nil)










