//
//  Realm+Bookmarks.swift
//  NYTimes
//
//  Created by Socratis Michaelides on 16/10/2017.
//

import Foundation

extension RealmManager {
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
		let storiesToRemove = stories.map { $0.title }
		realm.beginWrite()
		let objectsToDelete = realm.objects(BookmarkedStory.self).filter("title IN %@", storiesToRemove)
		realm.delete(objectsToDelete)
		do {
			try realm.commitWrite()
			completion(nil)
		}
		catch {
			completion(RealmError("Realm failed to commitWrite()"))
		}
	}
	
	public func isBookmarked(storyTitle: String) -> (Bool) {
		let bookmarkedStories = realm.objects(BookmarkedStory.self).filter("title IN %@", [storyTitle])
		guard bookmarkedStories.count > 0 else {
			return false
		}
		guard bookmarkedStories.first != nil else {
			return false
		}
		return true
	}
}
