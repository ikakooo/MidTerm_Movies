//
//  GradientView.swift
//  MidTerm_Movies
//
//  Created by MacBook Pro on 30.10.21.
//

import Foundation
import UIKit

@IBDesignable
final class GradientView: UIView {
    @IBInspectable var startColor: UIColor = UIColor.clear
    @IBInspectable var endColor: UIColor = UIColor.clear

    override func draw(_ rect: CGRect) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: CGFloat(0),
                                y: CGFloat(0),
                                width: superview!.frame.size.width,
                                height: superview!.frame.size.height)
        gradient.colors = [startColor.cgColor,startColor.cgColor, endColor.cgColor, endColor.cgColor, endColor.cgColor]
        gradient.zPosition = -1
        layer.addSublayer(gradient)
    }
}

@IBDesignable
final class GradientViewUIButton: UIButton {
    @IBInspectable var startColor: UIColor = UIColor.clear
    @IBInspectable var endColor: UIColor = UIColor.clear
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor = UIColor.clear

    override func draw(_ rect: CGRect) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: CGFloat(0),
                                y: CGFloat(0),
                                width: self.frame.size.width,
                                height: self.frame.size.height)
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.zPosition = -1
        gradient.cornerRadius = cornerRadius
        gradient.borderWidth = borderWidth
        gradient.borderColor = borderColor.cgColor
       
        layer.addSublayer(gradient)
    }
}

@IBDesignable
final class ShadowForUITextField: UITextField {
    @IBInspectable var shadowoffset: CGSize = CGSize.init(width: 0, height: 3)
    @IBInspectable var shadowCornerRadius: CGFloat = 2.0
    @IBInspectable var shadowColor: UIColor = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.35

    override func draw(_ rect: CGRect) {
        layer.masksToBounds = false
        layer.shadowOffset = shadowoffset
        layer.shadowColor = shadowColor.cgColor
        layer.shadowRadius = shadowCornerRadius
        layer.shadowOpacity = shadowOpacity

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}

