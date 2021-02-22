//
//  RoundedButton.swift
//  Millionaire
//
//  Created by Grigory Stolyarov on 21.02.2021.
//

import UIKit

//@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable var borderColor: UIColor = .black {
        didSet {
            self.setupView()
        }
    }
    
    @IBInspectable var fillColor: UIColor = .gray {
        didSet {
            self.setupView()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            self.setupView()
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        backgroundColor = fillColor
        layer.cornerRadius = frame.height / 2
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
    
}
