//
//  Utilities.swift
//  Futag
//
//  Created by Furkan Erdoğan on 9.01.2022.
//

import Foundation
import UIKit

class Utilities {
    
    func inputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
        let view = UIView()
        let iv = UIImageView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        iv.image = image
        
        view.addSubview(textField)
        textField.layer.cornerRadius = 20
        textField.backgroundColor = .textBoxGray
        textField.anchor(left: view.leftAnchor, bottom: view.bottomAnchor,
                         right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8, height: 50 )
        
        
        textField.addSubview(iv)
        textField.setLeftPaddingPoints(40)
        iv.tintColor = .black
        iv.anchor(left: textField.leftAnchor, bottom: textField.bottomAnchor,
                  paddingLeft: 8, paddingBottom: 15)
        iv.setDimensions(width: 21, height: 21)
        
        
        return view
    }
    
    func textField(withPlaceholder placeholder: String) -> UITextField {
        let tf = UITextField()
        
        tf.textColor = .black
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return tf
    }
    
    func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        button.tintColor = .label
        
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.label])
        
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.clubYellow]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }
}
