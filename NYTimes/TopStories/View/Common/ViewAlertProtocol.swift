//
//  ViewAlertProtocol.swift
//  NYTimes
//
//  Created by Socratis on 06/10/2017.
//

import Foundation
import UIKit

protocol ViewAlertProtocol: class {
    func showAlertController(controller alert: UIAlertController, completion: (() -> Void)?)
}
