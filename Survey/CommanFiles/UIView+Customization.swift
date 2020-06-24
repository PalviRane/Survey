//
//  UIView+Customization.swift
//  Survey
//
//  Created by Aakash Kumbhar on 24/06/20.
//  Copyright © 2020 Palvi. All rights reserved.
//

import UIKit

extension UIView
{
    @IBInspectable var shadowRadius: CGFloat
    {
        get {
            return layer.shadowRadius
        }
        set
        {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOffset : CGSize{

        get
        {
            return layer.shadowOffset
        }
        set{
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowColor : UIColor{
        get{
            return UIColor.init(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    @IBInspectable
    var shadowOpacity : Float {

        get{
            return layer.shadowOpacity
        }
        set {

            layer.shadowOpacity = newValue

        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
