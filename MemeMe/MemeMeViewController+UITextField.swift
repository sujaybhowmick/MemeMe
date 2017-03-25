//
//  MemeMeViewController+UITextField.swift
//  MemeMe
//
//  Created by Sujay Bhowmick on 3/25/17.
//  Copyright © 2017 Sujay Bhowmick. All rights reserved.
//

import UIKit

extension MemeMeViewController: UITextFieldDelegate {
    
    /** TextField functions **/
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
