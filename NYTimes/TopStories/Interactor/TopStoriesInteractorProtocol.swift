//
//  TopStoriesInteractorProtocol.swift
//  NYTimes
//
//  Created by Socratis Michaelides on 03/10/2017.
//

import Foundation
import CoreData

protocol TopStoriesInteractorProtocol: class {
	func fetchTopStories()
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> { get }
}
