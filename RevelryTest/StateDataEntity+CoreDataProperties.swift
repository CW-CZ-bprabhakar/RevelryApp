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
    
    convenience init(dictionary : NSDictionary) {
        self.init();
        self.id = dictionary["id"] as! Int;
        self.state = dictionary["state"] as! Int;
        self.name = dictionary["name"] as? String;
    }
    
    class func arrayOfModelsFromDictionaries(arr:NSArray) -> [StateDataEntity]{
        
        var response:[StateDataEntity] = [];
        for obj in arr {
            let dict = obj as! NSDictionary;
            response.append(StateDataEntity(dictionary: dict));
            
        }
        
        return response;
    }


}
