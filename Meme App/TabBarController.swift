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
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("AddNewMemeViewController") as! AddNewMemeViewController
       
                self.navigationController?.pushViewController(detailController, animated: true)

    }
    
    }












