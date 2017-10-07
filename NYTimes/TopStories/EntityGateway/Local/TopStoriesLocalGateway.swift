//
//  TopStoriesLocalGateway.swift
//  NYTimes
//
//  Created by Socratis Michaelides on 05/10/2017.
//

import Foundation
import CoreData

class TopStoriesLocalGateway: TopStoriesLocalGatewayProtocol {
    lazy var fetchedResultController: NSFetchedResultsController<NSFetchRequestResult> = {
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Story.self))
		fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
		let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.sharedInstance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
		return frc
	}()
}
