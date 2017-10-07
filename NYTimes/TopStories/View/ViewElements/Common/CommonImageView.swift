//
//  CommonImageView.swift
//  NYTimes
//
//  Created by Socratis on 06/10/2017.
//

import Foundation
import UIKit

class CommonImageView: UIImageView {
    override init(image: UIImage?) {
        super.init(image: image)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit() {
        self.contentMode = .scaleAspectFit
        self.layer.cornerRadius = 40
        self.layer.masksToBounds = true
        self.backgroundColor = #colorLiteral(red: 0.6640621424, green: 0.7653500438, blue: 0.2051630616, alpha: 1)
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
}
