//
//  MemeCaptionTextViewDelegate.swift
//  MemeMe 1.0
//
//  Created by Haeussermann, Tobias (059) on 02.03.21.
//

import Foundation
import UIKit

class MemeCaptionTextViewDelegate : NSObject, UITextFieldDelegate {
    
    let initialText: String!
    
    init(initialText: String) {
        self.initialText = initialText
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.text == initialText {
            textField.text = ""
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {             // Deletion mode
            textField.deleteBackward()
        } else {                        // Insert/Paste mode
            textField.text = (textField.text ?? "") + string.uppercased()
        }
    
        return false
    }
}
