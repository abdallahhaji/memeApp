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
        self.memeLabel1.text = ""
        self.memeLabel2.text = ""
        // hide tab bar as no need to switch b/w collection & table
        self.tabBarController?.tabBar.hidden = true
        // assign meme to the main Image
        self.memeImage!.image = self.memeInstance.memeImageWithText
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
}






