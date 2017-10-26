//
//  Injectable.swift
//  NYTimes
//
//  Created by Socratis Michaelides on 25/10/2017.
//

import Foundation

protocol Injectable {
	associatedtype Item
	
	func inject(item: Item)
	func assertDependencies()
}
