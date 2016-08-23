//
//  DataController.swift
//  RevelryTest
//
//  Created by Babul on 23/08/16.
//  Copyright © 2016 Babul. All rights reserved.
//

import UIKit

public class DataController: NSObject {
    /// singleton instance
    public static let sharedInstance  = DataController()
    var cacheDict:[String:AnyObject] = [:];
    private override init() {
        
    }
    
    
   public func getStateData() -> Data? {
        
       return self.cacheDict["api_data"] as? Data;
        
        
    }
    
   public func setStateData(data:Data?)  {
        
        if data != nil {
            self.cacheDict["api_data"] = data!;
        } else {
            self.cacheDict.removeValueForKey("api_data");
        }
        
    }
    
}
