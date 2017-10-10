//
//  FetchedResultsControllerProtocol.swift
//  NYTimes
//
//  Created by Socratis on 05/10/2017.
//

import Foundation
import CoreData

protocol FetchedResultsControllerProtocol: class {
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> { get }
}
