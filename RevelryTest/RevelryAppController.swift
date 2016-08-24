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
    
    
    
    public func checkAndGetDataFromNetwork() {
        
        
        if !CoreDataController.sharedInstance.isDataFetched() {
            self.getData({ (response) in
                if response.statusCode == 200 {
                    
                    CoreDataController.sharedInstance.addPendingStateObject(response.data);
                    CoreDataController.sharedInstance.setIsDataFetched(true);
                }
            });
        }
        
        
        
    }
    
    func getData(callback : (response:Data) -> Void) {
        Alamofire.request(.GET, URL, parameters: nil ,encoding: .JSON,headers: nil)
                .responseJSON { response in
                    
                    
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                        let responseObject = Data(dictionary: JSON as? NSDictionary, statusCode: response.response!.statusCode);
                        
                        callback(response: responseObject);
                       
                        
                        
                        
                    } else {
                        
                        callback(response: Data(dictionary: nil, statusCode: response.response!.statusCode));
                        
                    }
            }

        }
    
    
}


public class Data : NSObject {
    
    var data: [StateRes]!
    var statusCode : Int!
    
    
    init(dictionary : NSDictionary?,statusCode:Int) {
        
        self.statusCode = statusCode;
        if statusCode == 200 {
             self.data = StateRes.arrayOfModelsFromDictionaries(dictionary!["data"] as! [NSDictionary] )
        }
      
    }
    
}


public class StateRes {
    var id: Int!
    var name: String!
    var state: Bool!
    
    convenience init(dictionary : NSDictionary) {
        self.init();
        self.id = dictionary["id"] as! Int;
        self.state = dictionary["state"] as! Bool;
        self.name = dictionary["name"] as? String;
    }
    
    class func arrayOfModelsFromDictionaries(arr:NSArray) -> [StateRes]{
        
        var response:[StateRes] = [];
        for obj in arr {
            let dict = obj as! NSDictionary;
            response.append(StateRes(dictionary: dict));
            
        }
        
        return response;
    }
}

