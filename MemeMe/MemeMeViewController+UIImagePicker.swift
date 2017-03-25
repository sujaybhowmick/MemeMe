//
//  MemeMeViewController+UIImagePicker.swift
//  MemeMe
//
//  Created by Sujay Bhowmick on 3/5/17.
//  Copyright © 2017 Sujay Bhowmick. All rights reserved.
//

import UIKit

extension MemeMeViewController: UIImagePickerControllerDelegate {
 
    struct Alerts {
        static let DismissAlert = "Dismiss"
        static let CameraNotAvailable = "Camera not accessible"
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        print("this is debug")
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            imagePickerView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func showAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Alerts.DismissAlert, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
   
}
