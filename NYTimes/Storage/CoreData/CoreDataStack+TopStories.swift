//
//  CoreDataStack+TopStories.swift
//  
//
//  Created by Socratis on 06/10/2017.
//

import Foundation
import CoreData

//handles story entity transactions
extension CoreDataStack {
    
    //MARK: Parse JSON object to Core Data
    public func createStoryEntityFrom(json: StoryJSON) -> NSManagedObject? {
        if let storyEntity = NSEntityDescription.insertNewObject(forEntityName: "Story", into: getContext()) as? Story {
            storyEntity.title = json.title
            storyEntity.published_date = json.published_date
            storyEntity.imgUrl = json.imgUrl
            storyEntity.item_type = json.item_type
            storyEntity.abstract = json.abstract
            storyEntity.storyLink = json.storyLink
            return storyEntity
        }
        return nil
    }
    
    //MARK: Save story
    public func saveInCoreDataWith(jsonArray: [StoryJSON]) {
        _ = jsonArray.map{self.createStoryEntityFrom(json: $0)}
        do {
            try getContext().save()
        } catch let error {
            print(error)
        }
    }
}
