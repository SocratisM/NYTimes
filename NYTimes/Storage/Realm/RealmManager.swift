//
//  RealmManager.swift
//  NYTimes
//
//  Created by Socratis Michaelides on 13/10/2017.
//

import Foundation
import RealmSwift


class RealmManager: NSObject {
	
	static let sharedInstance = RealmManager()
	let realm = try! Realm()
	var bookmarkedStories = try! Realm().objects(BookmarkedStory.self).sorted(byKeyPath: "title")
	
	private override init() {
		
	}
	
	func addBookmark(story: StoryProtocol, completion: @escaping (Error?) -> ()) {
		realm.beginWrite()
		realm.create(BookmarkedStory.self, value: [story.title, story.imgUrl, story.item_type, story.published_date, story.abstract, story.storyLink	])
		do{
			try realm.commitWrite()
			completion(nil)
		}
		catch {
			completion(RealmError("Realm failed to commitWrite()"))
		}
	}
	
	func removeBookmarks(stories: [StoryProtocol], completion: @escaping (Error?) -> ()) {
		//fetch bookmarks
		let ids = bookmarkedStories.map { $0.title }
		realm.beginWrite()
		let objectsToDelete = realm.objects(BookmarkedStory.self).filter("title IN %@", ids)
		realm.delete(objectsToDelete)
		do {
			try realm.commitWrite()
			completion(nil)
		}
		catch {
			completion(RealmError("Realm failed to commitWrite()"))
		}
	}
}

struct RealmError: Error {
	let message: String
	
	init(_ message: String) {
		self.message = message
	}
	
	public var localizedDescription: String {
		return message
	}
}
