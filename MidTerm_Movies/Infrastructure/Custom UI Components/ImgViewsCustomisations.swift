//
//  ImgViewsCustomisations.swift
//  MidTerm_Movies
//
//  Created by MacBook Pro on 01.11.21.
//

import Foundation
import UIKit

@IBDesignable class RoundedImageView:UIImageView {
    @IBInspectable var borderColor:UIColor = UIColor.white {
        willSet {
            layer.borderColor = newValue.cgColor
        }
    }
    @IBInspectable var borderWidth:CGFloat = 1 {
        willSet {
            layer.borderWidth = 1
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/2
        layer.masksToBounds = true
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
}
