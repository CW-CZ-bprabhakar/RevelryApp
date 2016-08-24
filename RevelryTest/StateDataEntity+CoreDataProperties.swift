//
//  StateDataEntity+CoreDataProperties.swift
//  
//
//  Created by Babul on 24/08/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension StateDataEntity {

    @NSManaged var id: NSNumber?
    @NSManaged var name: String?
    @NSManaged var state: NSNumber?
    
   


}
