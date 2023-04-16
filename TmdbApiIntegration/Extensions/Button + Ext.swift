//
//  Button + Ext.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 15/04/23.
//

import Foundation
import UIKit

// MARK: UIButton Extension
extension UIButton {
    public func cornerRadius() {
        self.layer.cornerRadius = frame.size.height/2
    }
    public func blueBorderDesign() {
        self.layer.cornerRadius = frame.size.height/2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "Blue")?.cgColor
    }
    public func greenBorderDesign() {
        self.layer.cornerRadius = frame.size.height/2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "Green")?.cgColor
    }
}
