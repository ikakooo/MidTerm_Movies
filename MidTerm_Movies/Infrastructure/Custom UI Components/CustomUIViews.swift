//
//  CustomUIViews.swift
//  MidTerm_Movies
//
//  Created by MacBook Pro on 01.11.21.
//

import Foundation
import UIKit

@IBDesignable
class ShadowView: UIView {
    //Shadow
    @IBInspectable var shadowColor: UIColor = UIColor.black {
        didSet {
            self.updateView()
        }
    }
    var shadowOpacity: Float = 0.5 
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 3) {
        didSet {
            self.updateView()
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 15.0 {
        didSet {
            self.updateView()
        }
    }
    
    //Apply params
    func updateView() {
        self.layer.shadowColor = self.shadowColor.cgColor
        self.layer.shadowOpacity = self.shadowOpacity
        self.layer.shadowOffset = self.shadowOffset
        self.layer.shadowRadius = self.shadowRadius
    }
}
