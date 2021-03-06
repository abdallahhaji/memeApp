//
//  MemeInstance.swift
//  Meme App
//
//  Created by Abdallah Haji on 2015-08-01.
//  Copyright (c) 2015 Abdallah Haji. All rights reserved.
//

import Foundation
import UIKit

struct MemeInstance {
    
    // Data model - Each instance contains an image (camera/album) + 2 textfields + 1 meme
    var memeImage: UIImage?
    var memeTextField1: NSString?
    var memeTextField2: NSString?
    var memeImageWithText: UIImage?
    
    // initializing requires a parameter for each variable within the struct
    init(memeImage: UIImage?, memeTextField1: NSString?, memeTextField2: NSString?, memeImageWithText: UIImage?) {
        
        self.memeImage = memeImage
        self.memeTextField1 = memeTextField1
        self.memeTextField2 = memeTextField2
        self.memeImageWithText = memeImageWithText
        
    }

}
