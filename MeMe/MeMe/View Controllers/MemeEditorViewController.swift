//
//  ViewController.swift
//  MeMe
//
//  Created by Vlad Spreys on 5/03/15.
//  Copyright (c) 2015 Spreys.com. All rights reserved.
//


import UIKit


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!

    @IBOutlet weak var txtBottom: UITextField!
    @IBOutlet weak var txtTop: UITextField!

    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var meme : Meme?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        
        setupTextField(self.txtBottom)
        setupTextField(self.txtTop)
        
        self.txtBottom.text = "BOTTOM"
        self.txtTop.text = "TOP"
        self.shareButton.enabled = false
    }
    
    func setupTextField(textField: UITextField) {
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSStrokeWidthAttributeName: -5.0
        ]
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .Center
        textField.delegate = self;
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //Hide keyboard
        textField.resignFirstResponder()
        
        return true;
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotification()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotification()
    }
    
    @IBAction func pickAnImageFromCamera (sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromAlbum (sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.imageView.image = image
            self.shareButton.enabled = true
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func topTextBeginEditing(sender: UITextField){
        if(sender.text == "TOP"){
            sender.text = ""
        }
    }
    @IBAction func topTextEditingEnded(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func bottomTextBeginEditing(sender: UITextField) {
        if(sender.text == "BOTTOM"){
            sender.text = ""
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification: NSNotification){
        self.view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func subscribeToKeyboardNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotification() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:UIKeyboardWillHideNotification, object: nil)
    }
    
    func save() {
        var memmedImage = generateMemedImage()
        self.meme = Meme(topCaption: self.txtTop.text, bottomCaption: self.txtBottom.text, originalImage: imageView.image!, memedImage: memmedImage)
        
        //Update shared model
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as AppDelegate
        appDelegate.memes.append(self.meme!)
    }
    
    func generateMemedImage() -> UIImage {
        
        self.toolbar.hidden = true
        self.navigationController?.navigationBar.hidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.toolbar.hidden = false
        self.navigationController?.navigationBar.hidden = false
        
        return memedImage
    }
    
    @IBAction func openShareVie(sender: UIBarButtonItem) {
        save()
        
        var activityViewController = UIActivityViewController(activityItems: [self.meme!.memedImage], applicationActivities: nil)
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
}
