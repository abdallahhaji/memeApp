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
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    // assisgn history
    
    var history = [MemeInstance]()
    let imagePicker = UIImagePickerController()
    var memeInstance = MemeInstance(memeImage: nil, memeTextField1: nil, memeTextField2: nil, memeImageWithText: nil)
    
  
    
    
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -3.0
    ]
    
    
    
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true
        
       //  self.navigationItem.leftBarButtonItem?.enabled = false
        
        enableDisableShareButton()
        
        enableDisableCameraButton()
        
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
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "goBackToSentMemes")
        
        
        
        
       // textField1.attributedText = NSAttributedString(string: "Top", attributes: memeTextAttributes)
        
        textField2.attributedPlaceholder = NSAttributedString(string: "BOTTOM", attributes: memeTextAttributes)
        
        textField1.attributedPlaceholder = NSAttributedString(string: "TOP", attributes: memeTextAttributes)
        
       
        textField1.defaultTextAttributes = memeTextAttributes
        textField2.defaultTextAttributes = memeTextAttributes
        
        // self.textField1.clearsOnBeginEditing = true
        
        //self.textField2.clearsOnBeginEditing = true
        
       
        //self.textField1.placeholder = "Top"
        
    }
    
    func goBackToSentMemes() {
    
    
     performSegueWithIdentifier("Meme History", sender: self)
    
    }
    
    
    func enableDisableShareButton() {
    
        if mainImage.image == nil {
        
        self.navigationItem.leftBarButtonItem?.enabled = false
        } else {
        
        self.navigationItem.leftBarButtonItem?.enabled = true
        }
    
    }
    
    
    func enableDisableCameraButton() {
    
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) == true {
        
        self.cameraButton.enabled = true
        
        
        } else {
            
            self.cameraButton.enabled = false
        
        
        
        
        
        }
        
       
    
    
    }
    
    
    
    // assign the picked image to the main image
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        mainImage.image = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        //memeInstance.memeImage = mainImage!.image!
        self.dismissViewControllerAnimated(true, completion: nil)
        
        memeInstance = MemeInstance(memeImage: mainImage?.image, memeTextField1: textField1.text, memeTextField2: textField2.text, memeImageWithText: nil)
        
        //self.navigationItem.leftBarButtonItem?.enabled = true
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "shareMeme")
        
        
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
    
//    func textFieldDidBeginEditing(textField: UITextField) {
//        self.textField1.placeholder = nil
//    }
    
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
    
    
    
    func takeScreenShotOfMeme() {
    
    UIGraphicsBeginImageContextWithOptions(view.frame.size, true, 0.0)
    
    view.layer.renderInContext(UIGraphicsGetCurrentContext())
        let memeImageWithTextFields = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.memeInstance.memeImageWithText = memeImageWithTextFields
        
        
        
    }
    
    
    func generateMemedImage() {
        
        // TODO: Hide toolbar and navbar
        
        self.navigationController?.navigationBarHidden = true
       
        self.toolBar.hidden = true
        
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // TODO:  Show toolbar and navbar
        
        self.memeInstance.memeImageWithText = memedImage
        
        self.navigationController?.navigationBarHidden = false
       
        self.toolBar.hidden = false
    }
    
    
    
    func shareMeme() {
        
        //takeScreenShotOfMeme()
        
        generateMemedImage()
        
        memeInstance = MemeInstance(memeImage: mainImage?.image, memeTextField1: textField1.text, memeTextField2: textField2.text, memeImageWithText: self.memeInstance.memeImageWithText)
        let activityItems: MemeInstance = MemeInstance(memeImage: memeInstance.memeImage, memeTextField1: memeInstance.memeTextField1, memeTextField2: memeInstance.memeTextField2, memeImageWithText: self.memeInstance.memeImageWithText)
        let avc = UIActivityViewController(activityItems: [memeInstance.memeImage!, memeInstance.memeTextField1!, memeInstance.memeTextField2!, self.memeInstance.memeImageWithText!], applicationActivities: nil)
        self.presentViewController(avc, animated: true, completion: nil)
        avc.completionWithItemsHandler = doneSharingHandler
        
        //UIActivityViewControllerCompletionWithItemsHandler
    }
    
    func doneSharingHandler(activityType: String!, completed: Bool, returnedItems: [AnyObject]!, error: NSError!) {
        // Return if cancelled
        memeInstance = MemeInstance(memeImage: mainImage?.image, memeTextField1: textField1.text, memeTextField2: textField2.text, memeImageWithText: self.memeInstance.memeImageWithText)
        
        if (!completed) {
            return
        }
            
        else {
            
            
            self.history.append(memeInstance)
            performSegueWithIdentifier("Meme History", sender: self)
            println(self.memeInstance.memeImageWithText)
            
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
