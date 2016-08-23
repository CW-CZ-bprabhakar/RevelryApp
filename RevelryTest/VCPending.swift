//
//  ViewController.swift
//  RevelryTest
//
//  Created by Babul on 23/08/16.
//  Copyright © 2016 Babul. All rights reserved.
//

import UIKit

class VCPending: VCBase {

    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func addTask(sender: AnyObject) {
        let alertController = UIAlertController(title: "Add Task", message: "Please add any pending task that needs completion", preferredStyle: .Alert);
        
        alertController.addTextFieldWithConfigurationHandler { (tf) in
            tf.placeholder = "Task Name";
        }
        let okAction = UIAlertAction(title: "Ok", style: .Default) { (action) in
            self.dismissViewControllerAnimated(true, completion: nil);
           let tf =  alertController.textFields?.first
            
            
        }
        let cancelAction = UIAlertAction(title: "Ok", style: .Default) { (action) in
            self.dismissViewControllerAnimated(true, completion: nil);
         
            
            
        }
        
        alertController.addAction(okAction);
        alertController.addAction(cancelAction);
        
        
        self.presentViewController(alertController, animated: true, completion: nil);
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

