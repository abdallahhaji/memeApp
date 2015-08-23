//
//  TabBarController.swift
//  Meme App
//
//  Created by Abdallah Haji on 2015-08-03.
//  Copyright (c) 2015 Abdallah Haji. All rights reserved.
//

import Foundation

import UIKit

class TabBarController: UITabBarController {
    

    var history: [MemeInstance] = []
    
    override func viewDidLoad() {
      
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add New Meme", style: .Plain, target: self, action: "addNewMeme")
        
    }
    
    func addNewMeme() {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
       
                self.navigationController?.pushViewController(detailController, animated: true)

    }
    
    }













 //self.tabBarController?.viewControllers[0]

    //  @IBOutlet weak var tableView: UITableView!





// self.presentViewController(detailController, animated: true, completion: nil)

//    }





//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.history.count
//    }
//    
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeHistoryCollectionViewCell", forIndexPath: indexPath) as! MemeHistoryCollectionViewCell
//        
//        let memeInstance = self.history[indexPath.row]
//        
//        // Set the name and image
//        cell.memeLabel1.text = memeInstance.memeTextField1! as String
//        cell.memeImageView?.image = memeInstance.memeImage!
//        cell.memeLabel2.text = memeInstance.memeTextField1! as String
//        
//        return cell
//    }
//    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
//    {
//        
//        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeHistoryDetailViewController") as! MemeHistoryDetailViewController
//        detailController.memeInstance = self.history[indexPath.row]
//        self.navigationController!.pushViewController(detailController, animated: true)
//        
//        //         self.presentViewController(detailController, animated: true, completion: nil)
//        
//    }
//
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return history.count
//        
//        
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        let CellID = "HistoryCell"
//        
//        let cell = tableView.dequeueReusableCellWithIdentifier(CellID, forIndexPath: indexPath) as! UITableViewCell
//        
//        let memeInstance = self.history[indexPath.row]
//        
//        // cell.textLabel!.text = "test"
//        
//        cell.textLabel!.text = memeInstance.memeTextField1! as String
//        //cell.detailTextLabel!.text = memeInstance.memeTextField1! as String
//        cell.imageView?.image = memeInstance.memeImage!
//        
//        return cell
//    }
//    
//    
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
//        
//        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeHistoryDetailViewController") as! MemeHistoryDetailViewController
//        
//        
//        
//        detailController.memeInstance = self.history[indexPath.row]
//        
//        
//        self.navigationController?.pushViewController(detailController, animated: true)
//        
//        // self.presentViewController(detailController, animated: true, completion: nil)
//        
//    }
//    
//
    


