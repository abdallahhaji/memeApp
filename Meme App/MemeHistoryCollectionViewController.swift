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
    
    // array to store model
    var history: [MemeInstance] = []
    
    
    // outlet to defined flow layout for collectionView
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Show tab bar to switch b/w collection & tableviews
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add new meme button -> system item
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addNewMeme")
        
        //flow layout attributes
        let space: CGFloat = 2.0
        
        // fit exactly 3 cells with 2 spaces in b/w
        let dimension = (self.view.frame.size.width - (2 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
    
    // segue to new Edit Meme controller
    func addNewMeme() {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        detailController.history = self.history
        self.navigationController?.pushViewController(detailController, animated: true)
        
    }
    
    // # of itmes in collectionview -> as per array count
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.history.count
    }
    
    // assign meme to the background view
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeHistoryCollectionViewCell", forIndexPath: indexPath) as! MemeHistoryCollectionViewCell
        let memeInstance = self.history[indexPath.row]
        let imageView = UIImageView(image: memeInstance.memeImageWithText!)
        cell.backgroundView = imageView
        return cell
    }
    
    // when cell selected -> segue to the detail view controller
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeHistoryDetailViewController") as! MemeHistoryDetailViewController
        // pass along memeInstance -> the data array to the new VC
        detailController.memeInstance = self.history[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
}












