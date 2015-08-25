//
//  MemeHistoryViewController.swift
//  Meme App
//
//  Created by Abdallah Haji on 2015-08-01.
//  Copyright (c) 2015 Abdallah Haji. All rights reserved.
//

import Foundation
import UIKit

class MemeHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
   
    @IBOutlet weak var tableView: UITableView!
    var history: [MemeInstance] = []

    
    override func viewDidLoad() {

    
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addNewMeme")
    }

    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
        
        println(self.history.count)
        
    
    
    }
    
    func addNewMeme() {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("ViewController") as! ViewController

        detailController.history = self.history
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    

    // Table View Delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let CellID = "HistoryCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(CellID, forIndexPath: indexPath) as! UITableViewCell
        let memeInstance = self.history[indexPath.row]
       // cell.textLabel!.text = memeInstance.memeTextField1! as String
        // cell.imageView?.image = memeInstance.memeImage!
        cell.imageView?.image = memeInstance.memeImageWithText!
        cell.imageView?.transform = CGAffineTransformMakeScale(1.5, 0.75)
        
//        if memeInstance.memeTextField1 == nil && memeInstance.memeTextField2 == nil {
//        
//        cell.textLabel!.text = "Top...Bottom"
//        
//        } else if memeInstance.memeTextField1 == nil && memeInstance.memeTextField2 != nil {
//        
//        cell.textLabel!.text = "Top" + (memeInstance.memeTextField2 as! String)
//        
//        
//        } else if memeInstance.memeTextField1 != nil && memeInstance.memeTextField2 == nil {
//        
//        cell.textLabel!.text = (memeInstance.memeTextField1 as! String) + "Bottom"
//        
//        } else {
        
        cell.textLabel!.text = memeInstance.memeTextField1! as String + "..." + (memeInstance.memeTextField2! as String)
        
        
        
        cell.detailTextLabel!.text = ""
        
        
        println(memeInstance.memeTextField2)
        
        return cell
    }

    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeHistoryDetailViewController") as! MemeHistoryDetailViewController

        detailController.memeInstance = self.history[indexPath.row]
        self.navigationController?.pushViewController(detailController, animated: true)
        
       
        
    }
 
    
}









 // delete the uinavigationcontroller delegate -> just testing segue






 //cell.detailTextLabel!.text = memeInstance.memeTextField1! as String
 // cell.textLabel!.text = "test"


 // self.presentViewController(detailController, animated: true, completion: nil)

  //        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add New Meme", style: .Plain, target: self, action: "addNewMeme")



