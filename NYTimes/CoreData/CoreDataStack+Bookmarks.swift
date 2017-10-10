//
//  CoreDataStack+Bookmarks.swift
//  NYTimes
//
//  Created by Socratis on 06/10/2017.
//

import Foundation
import CoreData

//handles Bookmarked story transactions
extension CoreDataStack {
    
    func bookmarkRequest(storyTitle: String) -> NSFetchRequest<NSFetchRequestResult> {
        let predicate = NSPredicate(format: "title = %@", storyTitle)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BookmarkedStory")
        fetchRequest.predicate = predicate
        return fetchRequest
    }
    //Todo: Instead of filtering from titile, add unique ids that will match with the fetched remote stories. This way we can map local and remote stories and dont lose track of the bookmarks.
    //And as a consequence the bookmarks entity in core data wont be required. A single entity with a boolean value for bookmarked status would rather be used.
    public func isAlreadyBookmarked(storyTitle: String) -> (Bool) {
        
        do {
            let result = try
                getContext().fetch(bookmarkRequest(storyTitle: storyTitle))
            guard result.count > 0 else {
                return (false)
            }
            guard (result.first as? BookmarkedStory) != nil else {
                return (false)
            }
            return (true)
            
        } catch _ as NSError {
            return (false) //Todo: handle error
        }
    }
    
    //MARK: Add bookmark
    public func addToBookmarks(story: StoryProtocol) -> Bool {
        if let bookmarkedStoryEntity = NSEntityDescription.insertNewObject(forEntityName: "BookmarkedStory", into: getContext()) as? BookmarkedStory {
            bookmarkedStoryEntity.title = story.title
            bookmarkedStoryEntity.published_date = story.published_date
            bookmarkedStoryEntity.imgUrl = story.imgUrl
            bookmarkedStoryEntity.item_type = story.item_type
            bookmarkedStoryEntity.abstract = story.abstract
            bookmarkedStoryEntity.storyLink = story.storyLink
            do {
                try getContext().save()
                return true
            } catch let error {
                debugPrint(error)
                return false
            }
        }
        return false
    }
    
    //MARK: Remove bookmark
    public func removeBookmark( story: StoryProtocol) -> Bool {
        do {
            let result = try getContext().fetch(bookmarkRequest(storyTitle: story.title))
            let resultData = result as! [BookmarkedStory]
            
            for object in resultData {
                getContext().delete(object)
            }
        }
        catch let error as NSError  {
            //Todo: handle error
            print("Could not fetch bookmark \(error), \(error.userInfo)")
            return false
        }
        do {
            try getContext().save()
            //print("Bookmark Removed")
            return true
        } catch let error as NSError  {
            //Todo: handle error
            print("Could not delete \(error), \(error.userInfo)")
            return false
        }
    }
    
    //MARK: Fetch all bookmarks
    public func fetchBookmarkedStories() -> [BookmarkedStory] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BookmarkedStory")
        do {
            let results = try
                getContext().fetch(fetchRequest)
            return results as! [BookmarkedStory]
        } catch _ as NSError {
            return []
        }
    }
}

