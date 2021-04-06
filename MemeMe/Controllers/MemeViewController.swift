//
//  ViewController.swift
//  MemeMe
//
//  Created by Gozde Kardas on 15.03.2021.
//  Copyright © 2021 Gozde Kardas. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    // MARK: MEME text attributes
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: NSNumber(-5.0)
    ]
    
    // MARK: custom delegate for text fields
    let textDelegate = TextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextField(topText , with :  "TOP")
        configureTextField(bottomText , with :  "BOTTOM")
        
        enableOrDisableButton(cameraButton, isEnabled : UIImagePickerController.isSourceTypeAvailable(.camera))        
        enableOrDisableButton(shareButton, isEnabled : false)

    }
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func subscribeToKeyboardNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {

        if bottomText.isEditing{
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {

        view.frame.origin.y = 0
    }

    
    // MARK: get keyboard height
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {

        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    // MARK:cancel meme
    @IBAction func cancel(_ sender: Any) {
        imagePickerView.image = nil
        configureTextField(topText , with :  "TOP")
        configureTextField(bottomText , with :  "BOTTOM")
        
        enableOrDisableButton(shareButton, isEnabled : false)

    }
    
    // MARK: share meme
    @IBAction func shareMeme(_ sender: Any) {
        let memedImage = generateMemedImage()
        
        let activityVC = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
        
        activityVC.completionWithItemsHandler = { activity, completed, items, error in
            if !completed {
                // handle task not completed
                return
            }
            self.saveMeme()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func pickAnImage(_ sender: Any) {
        pickAnImage(from: .photoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        pickAnImage(from: .camera)
    }
    
    func pickAnImage(from source: UIImagePickerController.SourceType)
    {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = source
        present(pickerController,animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            imagePickerView.image=image
        }
        dismiss(animated: true, completion: nil)
        
        enableOrDisableButton(shareButton, isEnabled : true)
    }
    
    
    // MARK: save meme
    func saveMeme() {
            // Create the meme
        let meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
        
        (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
    }
    
    
    // MARK: generate meme image
    func generateMemedImage() -> UIImage {
        
        
        hideOrUnhideBar(isHidden : true)

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //unhide toolbar and navbar
        hideOrUnhideBar(isHidden : false)

        return memedImage
    }
    
    //MARK: hide unhide toolbar and navbar
    func hideOrUnhideBar( isHidden : Bool){
        toolBar.isHidden = isHidden
        navBar.isHidden = isHidden
    }
    
    func enableOrDisableButton( _ button : UIBarButtonItem , isEnabled : Bool){
        button.isEnabled = isEnabled
    }
    
    // MARK: configure text fields
    func configureTextField(_ textField : UITextField, with defaultText: String)
    {
        topText.delegate = textDelegate
        textField.text =  defaultText
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.center
    }
    
}

