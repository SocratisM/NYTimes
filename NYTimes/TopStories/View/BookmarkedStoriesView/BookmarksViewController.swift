//
//  BookmarksViewController.swift
//  NYTimes
//
//  Created by Socratis on 04/10/2017.
//

import UIKit
import Foundation
import RealmSwift

class BookmarksViewController: UIViewController, UICollectionViewDataSource {
	
	@IBOutlet weak var collectionView: UICollectionView!
	let cellReuseIdentifier = "BookmarkCollectionViewCell"
	var notificationToken: NotificationToken? 	//realm updates
	fileprivate var bookmarkedStories = RealmManager.sharedInstance.bookmarkedStories
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		title = "Bookmarks"
		
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.scrollDirection = .vertical
		flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/2-0.5, height: 250)
		flowLayout.minimumInteritemSpacing = 1.0
		flowLayout.minimumLineSpacing = 1.0
		collectionView.collectionViewLayout = flowLayout
		collectionView.register(BookmarkCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
		
		// Set realm notification block
		self.notificationToken = bookmarkedStories.observe { (changes: RealmCollectionChange) in
			self.collectionView.reloadData()
			}
		}

	override func viewWillAppear(_ animated: Bool) {
		collectionView.backgroundView = nil
		// bookmarkedStories = CoreDataStack.sharedInstance.fetchBookmarkedStories()
	}

	// MARK:- UICollectionView DataSource
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		let numberOfItems = bookmarkedStories.count
		if(numberOfItems == 0) {
			emptyResults()
		}
		return numberOfItems
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookmarkCollectionViewCell", for: indexPath) as! BookmarkCollectionViewCell
		let bookmarkedStory = bookmarkedStories[indexPath.row]
		let displayData = StoryDisplayData(story: bookmarkedStory as StoryProtocol)
		cell.setUpWith(displayData)
		return cell
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	private func emptyResults() {
		let emptyResults: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
		emptyResults.text  = "No results available"
		emptyResults.textColor  = .white
		emptyResults.textAlignment = .center
		collectionView.backgroundView  = emptyResults
	}
}
