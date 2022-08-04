//
//  CustomTextField.swift
//  Chattr
//
//  Created by Joao Pedro Oliveira on 23/07/22.
//

import UIKit

class CustomTextField: UITextField {

    init(placeholder: String, isSecure: Bool = false) {
        super.init(frame: .zero)
        
        isSecureTextEntry = isSecure
        borderStyle = .none
        font = UIFont.systemFont(ofSize: 16)
        textColor = .white
        keyboardAppearance = .dark
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
