//
//  TopStoriesPresenterProtocol.swift
//  NYTimes
//
//  Created by Socratis Michaelides on 03/10/2017.
//

import Foundation
import CoreData

protocol TopStoriesPresenterProtocol: FetchedResultsControllerProtocol {
	func presentError(title: String, error: Error)
	func startPresentationChanges()
	func endPresentationChanges()
	func addStory(indexPath: IndexPath)
	func removeStory(indexPath: IndexPath)
}
