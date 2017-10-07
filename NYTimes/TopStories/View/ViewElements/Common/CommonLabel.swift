//
//  CommonLabel.swift
//  NYTimes
//
//  Created by Socratis on 06/10/2017.
//

import Foundation
import UIKit

//Common label used in the app
//Todo: use a theme manager to style it
class CommonLabel: UILabel {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    func commonInit() {
        self.sizeToFit()
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = UIColor.white
        self.font = self.font.withSize(20)
    }
}
