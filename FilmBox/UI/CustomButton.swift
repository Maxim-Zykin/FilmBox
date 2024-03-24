//
//  CustomButton.swift
//  FilmBox
//
//  Created by Максим Зыкин on 24.03.2024.
//

import UIKit

class CustomButtons: UIButton {

    enum FontSize {
        case big
        case med
        case small
    }

    init(title: String, fontSize: FontSize) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        
        self.backgroundColor = UIColor(red: 255/255, green: 199/255, blue: 0/255, alpha: 255/255)
        
        switch fontSize{
        case .big:
            self.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        case .med:
            self.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        case .small:
            self.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

