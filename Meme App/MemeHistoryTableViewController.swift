//
//  MemeHistoryViewController.swift
//  Meme App
//
//  Created by Abdallah Haji on 2015-08-01.
//  Copyright (c) 2015 Abdallah Haji. All rights reserved.
//

import Foundation
import UIKit

class MemeHistoryTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // outlet for tableview and history array to store the meme model
    @IBOutlet weak var tableView: UITableView!
    var history: [MemeInstance] = []
    
    
    override func viewDidLoad() {
        
        // nav button -> system button to add new memes
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addNewMeme")
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        // reload the tableview each time viewcontroller appears
        self.tableView.reloadData()
    }
    
    // segue to Edit Meme View Controller when button clicked
    func addNewMeme() {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("AddNewMemeViewController") as! AddNewMemeViewController
        detailController.history = self.history
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
    // Table View Delegate -> define number of rows -> items in history array
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    
    // define image and text for each of the cells in the table
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let CellID = "HistoryCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(CellID, forIndexPath: indexPath) as! UITableViewCell
        
        // index as per row and array count
        let memeInstance = self.history[indexPath.row]
        
        // assign meme to each cells imageview
        cell.imageView?.image = memeInstance.memeImageWithText!
        
        // transform size of the the imageview to make bigger
        cell.imageView?.transform = CGAffineTransformMakeScale(1.5, 0.75)
        
        
        cell.textLabel!.text = memeInstance.memeTextField1! as String + "..." + (memeInstance.memeTextField2! as String)
        
        //Subtitle view detail text label -> empty
        cell.detailTextLabel!.text = ""

        return cell
    }
    
    
    // segue to detailvew controller when a cell is clicked
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeHistoryDetailViewController") as! MemeHistoryDetailViewController
        
        detailController.memeInstance = self.history[indexPath.row]
        self.navigationController?.pushViewController(detailController, animated: true)
 
    }
}






