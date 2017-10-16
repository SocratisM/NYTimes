//
//  BookmarkedStory+CoreDataClass.swift
//  NYTimes
//
//  Created by Socratis on 06/10/2017.
//

import Foundation
import RealmSwift

public class BookmarkedStory: Object, StoryProtocol  {
	@objc dynamic var title : String!
	@objc dynamic var imgUrl : String?
	@objc dynamic var item_type : String?
	@objc dynamic var published_date : String!
	@objc dynamic var abstract : String!
	@objc dynamic var storyLink : String?
}

