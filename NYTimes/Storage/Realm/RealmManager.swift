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
	//var topStories = try! Realm().objects(Story.self).sorted(byKeyPath: "title")
	
	private override init() { }
		
		// MARK: Clear All Top Stories Records
//		func clearData()  {
//			try! realm.write {
//				realm.delete(topStories)
//			}
//		}
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
