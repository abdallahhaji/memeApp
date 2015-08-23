//
//  ViewController.swift
//  Meme App
//
//  Created by Abdallah Haji on 2015-07-31.
//  Copyright (c) 2015 Abdallah Haji. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // variables for MemeImage and 2 textfields defined
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    
    // assisgn history
    
    var history = [MemeInstance]()
    let imagePicker = UIImagePickerController()
    var memeInstance = MemeInstance(memeImage: nil, memeTextField1: nil, memeTextField2: nil)
    
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        imagePicker.delegate = self
        textField1.delegate = self
        textField2.delegate = self
        
        // UIView move up when keyboard is displayed
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "shareMeme")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "cancel", style: .Plain, target: self, action: "goBackToSentMemes")
        
        
    }
    
    func goBackToSentMemes() {
    
    
     performSegueWithIdentifier("Meme History", sender: self)
    
    }
    
    
    // assign the picked image to the main image
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        mainImage.image = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        //memeInstance.memeImage = mainImage!.image!
        self.dismissViewControllerAnimated(true, completion: nil)
        
        memeInstance = MemeInstance(memeImage: mainImage?.image, memeTextField1: textField1.text, memeTextField2: textField2.text)
        
        
        ///testing
      //  self.history.append(memeInstance)
        
    }
    
    
    // pick an image from the pick button
    @IBAction func pickImage(sender: AnyObject) {
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
 
    @IBAction func pickImageFromCamera(sender: AnyObject) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        imagePicker.cameraCaptureMode = .Photo
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
        
    }
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y -= 150
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y += 150
    }
    
    
    func shareMeme() {
        
        memeInstance = MemeInstance(memeImage: mainImage?.image, memeTextField1: textField1.text, memeTextField2: textField2.text)
        let activityItems: MemeInstance = MemeInstance(memeImage: memeInstance.memeImage, memeTextField1: memeInstance.memeTextField1, memeTextField2: memeInstance.memeTextField2)
        let avc = UIActivityViewController(activityItems: [memeInstance.memeImage!, memeInstance.memeTextField1!, memeInstance.memeTextField2!], applicationActivities: nil)
        self.presentViewController(avc, animated: true, completion: nil)
        avc.completionWithItemsHandler = doneSharingHandler
        
        //UIActivityViewControllerCompletionWithItemsHandler
    }
    
    func doneSharingHandler(activityType: String!, completed: Bool, returnedItems: [AnyObject]!, error: NSError!) {
        // Return if cancelled
        memeInstance = MemeInstance(memeImage: mainImage?.image, memeTextField1: textField1.text, memeTextField2: textField2.text)
        memeInstance.test = "testing"
        if (!completed) {
            return
        }
            
        else {
            
            self.history.append(memeInstance)
            performSegueWithIdentifier("Meme History", sender: self)
            
        }
        

        
        /// what i was using for segue
        let storyboard = self.storyboard
        
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Meme History" {

            var tabBarController: UITabBarController = segue.destinationViewController as! UITabBarController
            var navController: AnyObject? = tabBarController.viewControllers?.first
            var destinationViewController_History : MemeHistoryViewController = navController!.viewControllers?.first as! MemeHistoryViewController;

            var navController2: AnyObject? = tabBarController.viewControllers?.last
            
            var destinationViewController_History_2: MemeHistoryCollectionViewController = navController2!.viewControllers?.first as! MemeHistoryCollectionViewController

            
             destinationViewController_History.history = self.history
             destinationViewController_History_2.history = self.history
            
          //  destinationViewController_History.history.append(memeInstance)
            
            // destinationViewController_History_2.history.append(memeInstance)
            
        }

        
    }
    
    // till here
    
}



























// var tabBarCOntroller : UITabBarController = segue.destinationViewController as! UITabBarController;



//var destinationViewController_History : MemeHistoryViewController = tabBarController.viewControllers?.first as! MemeHistoryViewController;

// til here











//   let controller = self.storyboard?.instantiateViewControllerWithIdentifier("MemeHistoryViewController")as! MemeHistoryViewController

// till here







// let controller = self.storyboard?.instantiateViewControllerWithIdentifier("MemeHistoryCollectionViewController")as! MemeHistoryCollectionViewController

// let controller = self.storyboard?.instantiateViewControllerWithIdentifier("TabBarController")as! UITabBarController


// let firstViewController = controller.viewControllers?.first as! MemeHistoryViewController


// was also using this

//  firstViewController.history.append(memeInstance)

//  self.presentViewController(firstViewController, animated: true, completion: nil)



//wasnt using this line
//self.navigationController?.pushViewController(controller, animated: true)





/// most important one -> could be for the image picker allocation


// allocating the picked image to main image -> however not yet setting it as the main image
//        func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
//            self.mainImage.image = image
//            self.dismissViewControllerAnimated(true, completion: nil)
//        }
// mainImage.image = memeInstance.memeImage



/// also important
//  var memeHistory = [MemeHistoryViewController]()





//        let memeInstance : MemeInstance = MemeInstance(memeImage: mainImage.image!, memeTextField1: textField1.text, memeTextField2: textField2.text)


//          memeInstance.memeImage = mainImage!.image!
//          memeInstance.memeTextField1 = textField1.text
//           memeInstance.memeTextField2 = textField2.text

//            controller.history[0].memeImage = memeInstance.memeImage
//            controller.history[0].memeTextField1 = memeInstance.memeTextField1
//            controller.history[0].memeTextField2 = memeInstance.memeTextField2
//append(memeInstance)



//    let image = UIImage()
//    let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
//
//    self.presentViewController(controller, animated: true, completion: nil)



/// http://stackoverflow.com/questions/28211993/how-to-use-uibarbuttonsystemitem-to-change-uibarbuttonitem-identifier-swift




// var memeInstance = MemeInstance(memeImage: self.mainImage.image!, memeTextField1: textField1.text, memeTextField2: textField2.text)


//    mainImage?.image = memeInstance.memeImage
//    memeInstance.memeTextField1 = textField1.text
//    memeInstance.memeTextField2 = textField2.text

//        memeInstance = MemeInstance(memeImage: mainImage?.image, memeTextField1: textField1.text, memeTextField2: textField2.text)


// textField1.text = memeInstance.memeTextField1 as String
//textField2.text = memeInstance.memeTextField2 as String


//        let avc = UIActivityViewController(activityItems: [memeInstance.memeImage, memeInstance.memeTextField1, memeInstance.memeTextField2], applicationActivities: nil)


// avc.completionWithItemsHandler = doneSharingHandler






//code i was using
