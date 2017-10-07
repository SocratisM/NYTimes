//
//  NYTimesConnector.swift
//  NYTimes
//
//  Created by Socratis Michaelides on 03/10/2017.
//

import Foundation
import UIKit

//This class Connects the app together

//For the first TopStories the clean architecture is used - its preferable in order to safely scale the app
//For the Bookmarks a more standard approach is used
class NYTimesConnector {
    
    fileprivate let storyboardName = "Main"
    
    lazy fileprivate var topStoriesRemoteGateway: TopStoriesRemoteGatewayProtocol  = {
        return TopStoriesRemoteGateway()
    }()
    lazy fileprivate var topStoriesLocalGateway: TopStoriesLocalGatewayProtocol  = {
        return TopStoriesLocalGateway()
    }()
    
    required init() { }
    
    func setupUI(_ window: UIWindow) {
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        //tab view 1
        guard let topStoriesViewController = storyboard.instantiateViewController(withIdentifier: "TopStoriesViewController") as? TopStoriesViewController else {
            abort()
        }
        //tab view 2
        guard let bookmarksViewController = storyboard.instantiateViewController(withIdentifier: "BookmarksViewController") as? BookmarksViewController else {
            abort()
        }
        
        //root controller
        let baseController = UITabBarController()
        topStoriesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        bookmarksViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        
        let viewControllersList = [topStoriesViewController, bookmarksViewController]
        setupTopStoriesView(topStoriesViewController)
        
        baseController.viewControllers = viewControllersList
        baseController.viewControllers = viewControllersList.map { UINavigationController(rootViewController: $0) }
        
        window.rootViewController = baseController
    }
    
    //setting up the architecture instances together
    func setupTopStoriesView(_ view: TopStoriesViewController) {

        let interactor = TopStoriesInteractor(remoteGateway: topStoriesRemoteGateway, localGateway: topStoriesLocalGateway)
        let presenter = TopStoriesPresenter(interactor: interactor)
        
        interactor.presenter = presenter
        presenter.view = view
        presenter.connector = self
        view.eventHandler = presenter
    }
}

