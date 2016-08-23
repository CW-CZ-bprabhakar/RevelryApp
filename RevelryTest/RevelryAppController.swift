//
//  RevelryAppController.swift
//  RevelryTest
//
//  Created by Babul on 23/08/16.
//  Copyright © 2016 Babul. All rights reserved.
//

import UIKit
import Alamofire
let URL = "https://dl.dropboxusercontent.com/u/6890301/tasks.json"
public class RevelryAppController: NSObject {
    /// singleton instance
    public static let sharedInstance  = RevelryAppController()
    private override init() {
        
    }
    
    public func getData(callback : (response:Data) -> Void) {
    
        let obj = DataController.sharedInstance.getStateData();
        
        if obj !=  nil {
            callback(response: obj!)
        } else {
            Alamofire.request(.GET, URL, parameters: nil ,encoding: .JSON,headers: nil)
                .responseJSON { response in
                    
                    
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                        let responseObject = Data(dictionary: JSON as? NSDictionary, statusCode: response.response!.statusCode);
                        DataController.sharedInstance.setStateData(responseObject)
                        callback(response: responseObject);
                        
                        
                        
                        
                    } else {
                        
                        callback(response: Data(dictionary: nil, statusCode: response.response!.statusCode));
                        
                    }
            }

        }
    
    }
}


public class Data : NSObject {
    
    var data: [DataResponse]!
    var statusCode : Int!
    
    
    init(dictionary : NSDictionary?,statusCode:Int) {
        
        self.statusCode = statusCode;
        if statusCode == 200 {
             self.data = DataResponse.arrayOfModelsFromDictionaries(dictionary!["data"] as! [NSDictionary] )
        }
      
    }
    
}


public class DataResponse :NSObject {
    
    var id : Int!;
    var name : String!
    var state:Int!
    
    init(dictionary : NSDictionary) {
        
        self.id = dictionary["id"] as! Int;
        self.state = dictionary["state"] as! Int;
        self.name = dictionary["name"] as! String;
    }
    
    class func arrayOfModelsFromDictionaries(arr:NSArray) -> [DataResponse]{
        
        var response:[DataResponse] = [];
        for obj in arr {
            let dict = obj as! NSDictionary;
            response.append(DataResponse(dictionary: dict));
            
        }
        
        return response;
    }

    
   
    /*
     {
     "data":[
     {
     "id":1,
     "name":"First task",
     "state": 1
     },
     {
     "id":2,
     "name":"Second task",
     "state": 0
     },
     {
     "id":3,
     "name":"Third task",
     "state": 1
     }
     ]
     }
     */
    
}