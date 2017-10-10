//
//  TopStoriesPresenter.swift
//  NYTimes
//
//  Created by Socratis Michaelides on 03/10/2017.
//

import Foundation
import CoreData
import UIKit

//Handles communication with interactor and view
class TopStoriesPresenter {
	
	fileprivate var interactor: TopStoriesInteractorProtocol
	weak var view: TopStoriesViewProtocol?
	weak var connector: NYTimesConnector?
    public var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>

	required init(interactor: TopStoriesInteractorProtocol) {
		self.interactor = interactor
        self.fetchedResultsController = interactor.fetchedResultsController
	}
}

extension TopStoriesPresenter: TopStoriesPresenterProtocol {
	
	func presentError(title: String, error: Error) {
        let alert = UIAlertController(title: title, message:error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
        view?.showAlertController(controller: alert, completion: nil)
	}
	
	func startPresentationChanges() {
		view?.startUpdate()
	}
	
	func addStory(indexPath: IndexPath) {
		view?.addStory(indexPath: indexPath)
	}

	func removeStory(indexPath: IndexPath) {
		view?.removeStory(indexPath: indexPath)
	}

    func endPresentationChanges() {
        view?.endUpdate()
	}
}

extension TopStoriesPresenter: TopStoriesEventHandlerProtocol {
	func viewDidLoad() {
		interactor.fetchTopStories()
	}
}
