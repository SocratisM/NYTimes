//
//  CoreDataStack.swift
//  NYTimes
//
//  Created by Socratis Michaelides on 03/10/2017.
//

import Foundation
import UIKit
import CoreData
import SwiftyJSON

//Singleton
class CoreDataStack: NSObject {
    
    static let sharedInstance = CoreDataStack()

    private override init() {
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "TopStoriesModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        if getContext().hasChanges {
            do {
                try getContext().save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: Clear All Data Records
    //Todo: Use later for refreshing when nescessary
    public func clearData()  {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Story.self))
            do {
                let objects  = try getContext().fetch(fetchRequest) as? [NSManagedObject]
                _ = objects.map{$0.map{getContext().delete($0)}}
                CoreDataStack.sharedInstance.saveContext()
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
}

//MARK: Get Context
extension CoreDataStack {
    func getContext() -> NSManagedObjectContext {
        return CoreDataStack.sharedInstance.persistentContainer.viewContext
    }
}
