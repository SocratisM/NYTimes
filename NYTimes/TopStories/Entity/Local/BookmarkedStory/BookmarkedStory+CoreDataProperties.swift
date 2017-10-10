//
//  BookmarkedStory+CoreDataProperties.swift
//  NYTimes
//
//  Created by Socratis on 06/10/2017.
//

import Foundation
import CoreData

extension BookmarkedStory: StoryProtocol {
    @nonobjc static func fetchRequest() -> NSFetchRequest<Story> {
        return NSFetchRequest<Story>(entityName: "BookmarkedStory");
    }
    @NSManaged var title : String
    @NSManaged var imgUrl : String?
    @NSManaged var item_type : String?
    @NSManaged var published_date : String
    @NSManaged var abstract : String
    @NSManaged var storyLink : String?
}
