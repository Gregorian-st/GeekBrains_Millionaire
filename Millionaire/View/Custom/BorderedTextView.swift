//
//  BorderedTextView.swift
//  Millionaire
//
//  Created by Grigory Stolyarov on 26.02.2021.
//

import UIKit

//@IBDesignable
class BorderedTextView: UITextView {
    
    @IBInspectable var borderColor: UIColor = .black {
        didSet {
            self.setupView()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            self.setupView()
        }
    }
    
    @IBInspectable var borderRadius: CGFloat = 5 {
        didSet {
            self.setupView()
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = borderRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }

}
