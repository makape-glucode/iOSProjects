//
//  CheckboxView.swift
//  toDoList
//
//  Created by Makape Tema on 2023/03/03.
//

import UIKit

class CheckboxView: UIView {

    private var isChecked = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.label.cgColor
        layer.cornerRadius = frame.size.width / 2.0
        backgroundColor = .systemBackground
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func toggleCheck() {
        self.isChecked = !isChecked
        
        if self.isChecked {
            backgroundColor = .systemBlue
        }
        else {
            backgroundColor = .systemBackground
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layer.borderColor = UIColor.label.cgColor
    }

}
