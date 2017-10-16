//
//  Story+CoreDataProperties.swift
//  NYTimes
//
//  Created by Socratis Michaelides on 05/10/2017.
//

import Foundation
import CoreData

extension Story: StoryProtocol {
    @NSManaged var title : String!
    @NSManaged var imgUrl : String?
    @NSManaged var item_type : String?
    @NSManaged var published_date : String!
    @NSManaged var abstract : String!
    @NSManaged var storyLink : String?
}

