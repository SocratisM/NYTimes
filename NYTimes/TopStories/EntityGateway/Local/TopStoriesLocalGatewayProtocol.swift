//
//  TopStoriesLocalGatewayProtocol.swift
//  NYTimes
//
//  Created by Socratis Michaelides on 05/10/2017.
//

import Foundation
import CoreData

protocol TopStoriesLocalGatewayProtocol {
	var fetchedResultController: NSFetchedResultsController<NSFetchRequestResult> { get }
}
