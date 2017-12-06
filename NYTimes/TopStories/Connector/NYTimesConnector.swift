//
//  NYTimesConnector.swift
//  NYTimes
//
//  Created by Socratis Michaelides on 03/10/2017.
//

import Foundation
import UIKit
import Onboard
import UIWindowTransitions
//This class Connects the app together

//For the first TopStories the clean architecture is used - its preferable in order to safely scale the app
//For the Bookmarks a more standard approach is used
class NYTimesConnector {
    
    fileprivate let storyboardName = "Main"
    
	lazy fileprivate var topStoriesRemoteGateway: TopStoriesRemoteGateway = {
        return TopStoriesRemoteGateway()
    }()
    lazy fileprivate var topStoriesLocalGateway: TopStoriesLocalGatewayProtocol  = {
        return TopStoriesLocalGateway()
    }()
    
    required init() { }
    
    func setupUI(_ window: UIWindow) {
		
		var options = UIWindow.TransitionOptions()
		
		//set user on board demo page
		let onBoardDemoPage = OnboardingContentViewController(title: "NYTimes", body: "Sample App in Swift that uses the NYTimes API", image:  UIImage(named: "placeholder_logo"), buttonText: "Get Started") { () -> Void in
			//todo: ask for some permisions for push and location
			let storyboard = UIStoryboard(name: self.storyboardName, bundle: nil)
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
			self.setupTopStoriesView(topStoriesViewController)
			
			baseController.viewControllers = viewControllersList
			baseController.viewControllers = viewControllersList.map { UINavigationController(rootViewController: $0) }
			
			var options = UIWindow.TransitionOptions()
			options.direction = .toBottom
			window.setRootViewController(baseController, options: options)
		}
		
		onBoardDemoPage.topPadding = 20;
		onBoardDemoPage.underIconPadding = 10;
		onBoardDemoPage.underTitlePadding = 15;
		onBoardDemoPage.bottomPadding = 20;
		
		onBoardDemoPage.iconImageView.contentMode = .scaleAspectFit
		
		let onboardingVC = OnboardingViewController(backgroundImage: nil, contents: [onBoardDemoPage])
		onboardingVC?.view.contentMode = .scaleAspectFit
		onboardingVC?.view.backgroundColor = UIColor.white
		onboardingVC?.shouldBlurBackground = true
		onboardingVC?.shouldFadeTransitions = true
		onboardingVC?.pageControl.hidesForSinglePage = true
		options.direction = .toLeft
		window.setRootViewController(onboardingVC!, options: options)
    }
	
	
    
    //setting up the clean architecture instances together
    func setupTopStoriesView(_ view: TopStoriesViewController) {

        let interactor = TopStoriesInteractor(remoteGateway: topStoriesRemoteGateway, localGateway: topStoriesLocalGateway)
        let presenter = TopStoriesPresenter(interactor: interactor)
        
        interactor.presenter = presenter
        presenter.view = view
        presenter.connector = self
        view.eventHandler = presenter
    }
}

