//
//  StoryDetailsViewController.swift
//  NYTimes
//
//  Created by Socratis on 06/10/2017.
//

import Foundation
import UIKit

class StoryDetailsViewController: UIViewController, ViewAlertProtocol {
	
	@IBOutlet weak var storyImgView: UIImageView!
	@IBOutlet weak var abstractTextView: UITextView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var published_date: UILabel!
	@IBOutlet weak var bookmarkButton: UIButton!
	var currentStory: StoryProtocol!
	
	override func viewDidLoad() {
		setupUI()
	}
	
	//Todo: Add logic to remove item from bookmarks using a single button
	@IBAction func bookmarkButtonTapped(_ sender: Any) {
		let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: UIAlertControllerStyle.alert)
		
		let isBookmarked = CoreDataStack.sharedInstance.isAlreadyBookmarked(storyTitle: currentStory.title)
		
		if(!isBookmarked) {
			
			RealmManager.sharedInstance.addBookmark(story: currentStory, completion: {(error) in
				alert.title = "Added"
				alert.message = "Story bookmarked"
				if(error != nil) {
					alert.title = "Error"
					alert.message = error?.localizedDescription
				}
			})
			
		}
		else {
			RealmManager.sharedInstance.removeBookmarks(stories: [currentStory], completion: {(error) in
				alert.title = "Removed"
				alert.message = "Story removed from bookmarks"
				if(error != nil) {
					alert.title = "Error"
					alert.message = error?.localizedDescription
				}
			})
			setBookmarkButton()
			showAlertController(controller: alert, completion: nil)
		}
	}
	
	func showAlertController(controller alert: UIAlertController, completion: (() -> Void)?) {
		alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
	
	@IBAction func viewOriginalStoryTapped(_ sender: Any) {
		guard let url = URL(string: currentStory.storyLink!) else {
			return
		}
		UIApplication.shared.open(url, options: [:], completionHandler: nil)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

extension StoryDetailsViewController: StoryDisplayDelegate {
	func didReceiveImage(image: UIImage) {
		DispatchQueue.main.async(execute: {
			self.storyImgView.image = image
		})
	}
}

fileprivate extension StoryDetailsViewController {
	
	fileprivate func setupUI() {
		let displayData = StoryDisplayData(story: currentStory)
		displayData.delegate  = self
		titleLabel.text = "Title: \(String(describing: displayData.title))"
		published_date.text = "Published at: \(String(describing: displayData.published_date))"
		abstractTextView.text = displayData.abstract
		setBookmarkButton()
	}
	
	fileprivate func setBookmarkButton() {
		let isBookmarked = CoreDataStack.sharedInstance.isAlreadyBookmarked(storyTitle: currentStory.title)
		if(isBookmarked) {
			bookmarkButton.setTitle("Remove bookmark", for: .normal)
		}
		else {
			bookmarkButton.setTitle("Add bookmark", for: .normal)
		}
	}
}
