//
//  MemeHistoryDetailViewController.swift
//  Meme App
//
//  Created by Abdallah Haji on 2015-08-03.
//  Copyright (c) 2015 Abdallah Haji. All rights reserved.
//

import Foundation

import UIKit

class MemeHistoryDetailViewController : UIViewController {
    

    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var memeLabel1: UILabel!
    @IBOutlet weak var memeLabel2: UILabel!
    
    var memeInstance: MemeInstance!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.memeLabel1.text = self.memeInstance.memeTextField1 as? String
        self.memeLabel2.text = self.memeInstance.memeTextField2 as? String
        self.tabBarController?.tabBar.hidden = true
       // self.memeImage!.image = self.memeInstance.memeImage
        self.memeImage!.image = self.memeInstance.memeImageWithText
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
}






