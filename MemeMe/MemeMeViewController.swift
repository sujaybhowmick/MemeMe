//
//  MemeMeViewController.swift
//  MemeMe
//
//  Created by Sujay Bhowmick on 2/27/17.
//  Copyright © 2017 Sujay Bhowmick. All rights reserved.
//

import UIKit

class MemeMeViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var topMemeTextField: UITextField!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var bottomMemeTextField: UITextField!
    
    @IBOutlet weak var navBar: UIToolbar!
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.black,
        NSForegroundColorAttributeName : UIColor.white,
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 32)!,
        NSStrokeWidthAttributeName : -3.0
    ] as [String : Any]
    
    
    override func viewDidLoad() {
        configure(topMemeTextField, defaultAttributes: memeTextAttributes, defaultText: "TOP", textAlignment: .center)
        configure(bottomMemeTextField, defaultAttributes: memeTextAttributes, defaultText: "BOTTOM", textAlignment: .center)
    }
    
    func configure(_ textField: UITextField, defaultAttributes: [String: Any], defaultText: String,
                   textAlignment: NSTextAlignment){
        textField.defaultTextAttributes = defaultAttributes
        textField.text = defaultText
        textField.textAlignment = textAlignment
        textField.delegate = self
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        if imagePickerView.image == nil {
            shareButton.isEnabled = false
        } else {
            shareButton.isEnabled = true
        }
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    @IBAction func pickImageFromCamera(_ sender: Any) {
        pickAnImage(sender, .camera)
    }
    
    @IBAction func pickImageFromAlbum(_ sender: Any) {
        pickAnImage(sender, .photoLibrary)
    }
    
    @IBAction func shareAction(_ sender: Any) {
        let memedImage = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityController.completionWithItemsHandler = { activity, success, items, error in
            if !success {
                return
            }
            self.saveMeme()
            self.dismiss(animated: true, completion: nil)
        }
        present(activityController, animated: true, completion: nil)
    }
    
    func saveMeme() {
        //Create the meme
        let memedImage = generateMemedImage()
        
        let meme = Meme(topText: topMemeTextField.text!, bottomText: bottomMemeTextField.text!,
                        image: imagePickerView.image!, memedImage: memedImage)
        
        // Add it to the memes array in the Application Delegate
        (UIApplication.shared.delegate as!
            AppDelegate).memes.append(meme)
    }
    
    @IBAction func resetViewController(_ sender: AnyObject) {
        imagePickerView.image = nil
        shareButton.isEnabled = false
        topMemeTextField.text = "TOP"
        bottomMemeTextField.text = "BOTTOM"
    }
    
    func pickAnImage(_ sender: Any, _ sourceType: UIImagePickerControllerSourceType){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = sourceType
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    

    func validateTextField(textField: UITextField) -> Bool {
        if textField.hasText {
            return (textField.text?.lengthOfBytes(using: String.Encoding.utf8))! <= 45
        }
        return false
    }
    
    /** Keyboard functions **/
    
    func keyboardWillShow(_ notification:Notification) {
        if bottomMemeTextField.isFirstResponder {
            view.frame.origin.y = getKeyboardHeight(notification) * (-1)
        }
    }
    
    func keyboardWillHide(_ notification:Notification) {
        if bottomMemeTextField.isFirstResponder {
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func generateMemedImage() -> UIImage {
        navBar.isHidden = true
        toolBar.isHidden = true
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        navBar.isHidden = false
        toolBar.isHidden = false
        
        return memedImage
    }


}

