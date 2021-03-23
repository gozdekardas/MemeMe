//
//  TextFieldDelegate.swift
//  MemeMe
//
//  Created by Gozde Kardas on 22.03.2021.
//  Copyright © 2021 Gozde Kardas. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {


    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField.text == "TOP" ||  textField.text == "BOTTOM") {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
