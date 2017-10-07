//
//  TopStoriesInteractor.swift
//  NYTimes
//
//  Created by Socratis on 03/10/2017.
//

import Foundation
import CoreData

//Handles communication with storage and the presenter
class TopStoriesInteractor: NSObject {
    
    fileprivate var remoteGateway: TopStoriesRemoteGatewayProtocol
    fileprivate var localGateway: TopStoriesLocalGatewayProtocol
    
    public var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>
    weak var presenter: TopStoriesPresenterProtocol?
    
    required init(remoteGateway: TopStoriesRemoteGatewayProtocol, localGateway: TopStoriesLocalGatewayProtocol) {
        self.remoteGateway = remoteGateway
        self.localGateway = localGateway
        fetchedResultsController = self.localGateway.fetchedResultController
    }
}

extension TopStoriesInteractor: TopStoriesInteractorProtocol {
    func fetchTopStories() {
        fetchedResultsController.delegate = self
        loadLocalStories()
        //fetch any remove stories and parse into local stories
        remoteGateway.fetchTopStories(completion: {(stories, error) in
            guard error == nil else {
                self.presenter?.presentError(title: "Error", error: error!)
                return
            }
            guard let remoteStories = stories else {
                return
            }
            CoreDataStack.sharedInstance.saveInCoreDataWith(jsonArray: remoteStories)
        })
    }
    
    func loadLocalStories() {
        do {
            try fetchedResultsController.performFetch()
            debugPrint("local stories fetch count: \(String(describing: fetchedResultsController.sections?[0].numberOfObjects))")
        } catch let error  {
            debugPrint("error fetching local stories: \(error)")
            return
        }
    }
    
    func getLocalStories() -> [Story] {
        guard let stories = localGateway.fetchedResultController.fetchedObjects as? [Story] else {
            return [Story]()
        }
        return stories
    }
}
// MARK: - NSFetchedResultsControllerDelegate
extension TopStoriesInteractor: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                presenter?.addStory(indexPath: newIndexPath)
            }
        case .delete:
            if let indexPath = indexPath {
                presenter?.removeStory(indexPath: indexPath)
            }
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        presenter?.endPresentationChanges()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        presenter?.startPresentationChanges()
    }
}

