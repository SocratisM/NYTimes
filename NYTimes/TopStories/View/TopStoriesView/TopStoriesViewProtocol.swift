//
//  TopStoriesViewProtocol.swift
//  NYTimes
//
//  Created by Socratis on 03/10/2017.
//

import Foundation
import UIKit
import CoreData

protocol TopStoriesViewProtocol: ViewAlertProtocol {
	func startUpdate()
	func endUpdate()
	func addStory(indexPath: IndexPath)
	func removeStory(indexPath: IndexPath)
}
