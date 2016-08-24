//
//  CoreDataController.swift
//  RevelryTest
//
//  Created by Babul on 24/08/16.
//  Copyright © 2016 Babul. All rights reserved.
//

import UIKit
import CoreData

public class CoreDataController: NSObject {
    var managedObjectContext: NSManagedObjectContext
    /// singleton instance
    public static let sharedInstance  = CoreDataController()
   
  private  override  init() {
        // This resource is the same name as your xcdatamodeld contained in your project.
        guard let modelURL = NSBundle.mainBundle().URLForResource("State", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        self.managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        self.managedObjectContext.persistentStoreCoordinator = psc
        
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let docURL = urls[urls.endIndex-1]
        /* The directory the application uses to store the Core Data store file.
         This code uses a file named "DataModel.sqlite" in the application's documents directory.
         */
        let storeURL = docURL.URLByAppendingPathComponent("State.sqlite")
        do {
            try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
        } catch {
            fatalError("Error migrating store: \(error)")
        }
        
    }
    
    
    func isDataFetched() -> Bool {
        
        return NSUserDefaults.standardUserDefaults().boolForKey("isDataFetched");
        
    }
    
    func setIsDataFetched(isDataFetched : Bool)  {
        NSUserDefaults.standardUserDefaults().setBool(isDataFetched, forKey: "isDataFetched");
    }
    
    
    func addPendingStateObject(stateArr : [StateRes]) {
        // create an instance of our managedObjectContext
        let moc = self.managedObjectContext
        
        
        for stateObj in stateArr {
            // we set up our entity by selecting the entity and context that we're targeting
            let entity = NSEntityDescription.insertNewObjectForEntityForName("StateDataEntity", inManagedObjectContext: moc) as! StateDataEntity
            
            // add our data
            entity.id = stateObj.id;
            entity.state = stateObj.state;
            entity.name = stateObj.name;
            
            // we save our entity
           
        }
        do {
            try moc.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    
    func deleteObject(obj : StateDataEntity) {
         let moc = self.managedObjectContext
      moc.deleteObject(obj);
       
        do {
            try moc.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }

    }
    
    
}





