//
//  ViewController.swift
//  Meme App
//
//  Created by Abdallah Haji on 2015-07-31.
//  Copyright (c) 2015 Abdallah Haji. All rights reserved.
//

import UIKit

class AddNewMemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // variables for Meme picture, 2 textfields, Toolbar & camera button defined
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    // assigning an instance of the meme model to memeInstance & defining the image picking constant
    
    var history = [MemeInstance]()
    let imagePicker = UIImagePickerController()
    var memeInstance = MemeInstance(memeImage: nil, memeTextField1: nil, memeTextField2: nil, memeImageWithText: nil)
    
    
    // attributes for the text fields and placholder text
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 50)!,
        NSStrokeWidthAttributeName : -3.0
    ]
    
    override func viewWillAppear(animated: Bool) {
        
        // hide inhertied tab bar for this view controller since we need a tool bar
        self.tabBarController?.tabBar.hidden = true
        
        // used to move keyboard up down
        self.subscribeToKeyboardNotifications()
        
        // disable camera button if no access to camera.. and disable share button if no image is selected
        enableDisableShareButton()
        enableDisableCameraButton()
    }
    
// unsubscribe from notifications when view dissappears
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // assign delegates for the image picker and textfields
        imagePicker.delegate = self
        textField1.delegate = self
        textField2.delegate = self
        
        // UIView move up when keyboard is displayed
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
        // Share button and Cancel buttons
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "shareMeme")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "goBackToSentMemes")
        
      // attributes for the textfields/palceholders as defined above
        textField2.attributedPlaceholder = NSAttributedString(string: "BOTTOM", attributes: memeTextAttributes)
        textField1.attributedPlaceholder = NSAttributedString(string: "TOP", attributes: memeTextAttributes)
        textField1.defaultTextAttributes = memeTextAttributes
        textField2.defaultTextAttributes = memeTextAttributes
    }
    
    // return to sent Memes if Cancel is clicked
    func goBackToSentMemes() {
        performSegueWithIdentifier("Meme History", sender: self)
    }
    

    // if the uiimage is empty, disable the share button
    func enableDisableShareButton() {
        if mainImage.image == nil {
            self.navigationItem.leftBarButtonItem?.enabled = false
        } else {
            self.navigationItem.leftBarButtonItem?.enabled = true
        }
    }
    
    // if no camera source type -> disable the camera button
    func enableDisableCameraButton() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) == true {
            self.cameraButton.enabled = true
        } else {
            self.cameraButton.enabled = false
        }
    }

    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
       
        // assign the picked image to the main image
        mainImage.image = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        
        // dismiss the image picker animation
        self.dismissViewControllerAnimated(true, completion: nil)
       /// memeInstance = MemeInstance(memeImage: mainImage?.image, memeTextField1: textField1.text, memeTextField2: textField2.text, memeImageWithText: nil)
    }

    // Album Button to pick an image
    @IBAction func pickImage(sender: AnyObject) {
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    // Access Camera
    @IBAction func pickImageFromCamera(sender: AnyObject) {
        // dont allow editing...Camera is source type.. allow photos only
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        imagePicker.cameraCaptureMode = .Photo
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
  // textfield delegate -> edit text field
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    
    // textfield delegate -> resign first responder on return button
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    

    // get a hold of keyboard height
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    // get access to notification messages -> used for keyboard
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:"    , name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:"    , name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // remove notification messages -> used for keyboard
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
        
    }
    
    // for the bottom text field -> move UI up to prevent hiding
    func keyboardWillShow(notification: NSNotification) {
        if self.textField2.isFirstResponder() == true {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }

    // bottom textield -> move UI down by keyboard height when first responder resigned
    func keyboardWillHide(notification: NSNotification) {
        if self.textField2.isFirstResponder() == true {
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    // create a meme by taking a screenshot of the view, minue the toolbar and nav bar
    func generateMemedImage() {
        
        
        // hide the tool bar + nav bar while the screenshot is being taken
        self.navigationController?.navigationBarHidden = true
        self.toolBar.hidden = true
        
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // pass the meme onto the memeinstance so that the data can be passed to new view controllers if required
        
        self.memeInstance.memeImageWithText = memedImage
        
        // bring the tool bar + nav bar back, once the screenshot it taken.
        self.navigationController?.navigationBarHidden = false
        self.toolBar.hidden = false
    }
    

    // generate the meme and pass the meme instance to the the activity view controller.
    func shareMeme() {
        generateMemedImage()
        memeInstance = MemeInstance(memeImage: mainImage?.image, memeTextField1: textField1.text, memeTextField2: textField2.text, memeImageWithText: self.memeInstance.memeImageWithText)
        let activityItems: MemeInstance = MemeInstance(memeImage: memeInstance.memeImage, memeTextField1: memeInstance.memeTextField1, memeTextField2: memeInstance.memeTextField2, memeImageWithText: self.memeInstance.memeImageWithText)
        let avc = UIActivityViewController(activityItems: [memeInstance.memeImage!, memeInstance.memeTextField1!, memeInstance.memeTextField2!, self.memeInstance.memeImageWithText!], applicationActivities: nil)
        self.presentViewController(avc, animated: true, completion: nil)
        
        // when the avc is dismissed -> if completed, segue to new controller. if cancelled, return to the meme editor
        avc.completionWithItemsHandler = doneSharingHandler
    }
    

    // if 2 textfields are left empty -> turn their placeholder text into the stored text
    func turnPlaceholderTextIntoActualTextIfTextFieldsLeftEmpty () {
    
        if self.memeInstance.memeTextField1 == "" {
        
        self.memeInstance.memeTextField1 = "TOP"
        }
        
        if self.memeInstance.memeTextField2 == "" {
        self.memeInstance.memeTextField2 = "BOTTOM"
        
        }
    }
    
    // once the avc is completed, either segue to the new view, or return if cancelled
    func doneSharingHandler(activityType: String!, completed: Bool, returnedItems: [AnyObject]!, error: NSError!) {
        // Return if cancelled
        memeInstance = MemeInstance(memeImage: mainImage?.image, memeTextField1: textField1.text, memeTextField2: textField2.text, memeImageWithText: self.memeInstance.memeImageWithText)
        if (!completed) {
            return
        }
        else {
            
            // if textfields left empty -> convert the placeholder text into the stored text
            turnPlaceholderTextIntoActualTextIfTextFieldsLeftEmpty()
            // store the meme image, the meme, and 2 textfields in the history array of type memeinstance
            self.history.append(memeInstance)
            // perform the segway
            performSegueWithIdentifier("Meme History", sender: self)
        }

        /// what i was using for segue
        let storyboard = self.storyboard

    }
    
    // segue to the meme history table view controller. Pass all data(2 images + 2 text fields) to both the collection view and table view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Meme History" {
            
           // get a hold of the tab bar
            var tabBarController: UITabBarController = segue.destinationViewController as! UITabBarController
            
            // get a hold of the nav controller in b/w the tab bar controller and the destination view controller -> MemeHistory in tableview
            var navController: AnyObject? = tabBarController.viewControllers?.first
            
            // use nave controller to get a hold of the tableview
            var destinationViewController_History : MemeHistoryTableViewController = navController!.viewControllers?.first as! MemeHistoryTableViewController;
            
            //create another instance of nav controller -> placed before the collectionview
            var navController2: AnyObject? = tabBarController.viewControllers?.last
            
            // use nav controller 2 to get a hold of the collection view controller
            var destinationViewController_History_2: MemeHistoryCollectionViewController = navController2!.viewControllers?.first as! MemeHistoryCollectionViewController
            
            // append the history array in both view controller with the history array in this view controller
            destinationViewController_History.history = self.history
            destinationViewController_History_2.history = self.history
            
        }
    }
}


