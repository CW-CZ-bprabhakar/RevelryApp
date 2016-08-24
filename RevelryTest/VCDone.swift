//
//  VCDone.swift
//  RevelryTest
//
//  Created by Babul on 23/08/16.
//  Copyright © 2016 Babul. All rights reserved.
//

import UIKit
import CoreData
class VCDone: VCBase {

  
    
    
    override func viewDidLoad() {
       
        self.predicate = NSPredicate(format: "state = 1");
      
        super.viewDidLoad()
        
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    

}
