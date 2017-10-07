//
//  Story+CoreDataProperties.swift
//  NYTimes
//
//  Created by Socratis Michaelides on 05/10/2017.
//

import Foundation
import CoreData

extension Story: StoryProtocol {
    @nonobjc static func fetchRequest() -> NSFetchRequest<Story> {
        return NSFetchRequest<Story>(entityName: "Story");
    }
    @NSManaged var title : String
    @NSManaged var imgUrl : String?
    @NSManaged var item_type : String?
    @NSManaged var published_date : String
    @NSManaged var abstract : String
    @NSManaged var storyLink : String?
    //Todo: In the future, we should keep track of the bookmarked stories using a unique id to store the keys and perform the mapping on the fetched remote stories when all items are deleted. That way we wont need to duplicate the entity.
    //@NSManaged var bookmarked : Bool
}

