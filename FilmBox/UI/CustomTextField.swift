//
//  CustomTextField.swift
//  FilmBox
//
//  Created by Максим Зыкин on 24.03.2024.
//

import UIKit

class CustomTextField: UITextField, UITextFieldDelegate {

    enum CustomTextFieldType {
        case search
        case result
    }

    private let authFiledType: CustomTextFieldType
    
    init(filedTypr: CustomTextFieldType){
        self.authFiledType = filedTypr
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 255/255)
        
        self.layer.borderWidth = 2
        self.layer.borderColor = CGColor(red: 255/255, green: 199/255, blue: 0/255, alpha: 255/255)
        
        self.layer.cornerRadius = 10
        
        self.textColor = .white
        self.attributedPlaceholder = NSAttributedString(string: " ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
    
        switch filedTypr{
        case .search:
            self.placeholder = "Поиск"
        case .result:
            self.placeholder = ""
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

