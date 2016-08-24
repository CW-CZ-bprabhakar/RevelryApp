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
       
        self.predicate = NSPredicate(format: "state = 0");
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
            
           
            if tf?.text?.characters.count  > 0 {
                let stateObjEntity = StateRes();
                stateObjEntity.state =  false;
                
                stateObjEntity.name = tf?.text!;
                
                let obj =  (self.fetchedResultsController.fetchedObjects?.last) as? StateDataEntity;
                
                if obj != nil {
                    stateObjEntity.id = obj!.id!.integerValue + 1
                } else {
                    stateObjEntity.id = 0;
                }
                
                CoreDataController.sharedInstance.addPendingStateObject([stateObjEntity]);
                
            }
            
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Destructive) { (action) in
            self.dismissViewControllerAnimated(true, completion: nil);
         
            
            
        }
        
        alertController.addAction(okAction);
        alertController.addAction(cancelAction);
        
        
        self.presentViewController(alertController, animated: true, completion: nil);
        
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        
//        
//        let obj = self.fetchedResultsController.objectAtIndexPath(indexPath) as! StateDataEntity;
//        obj.state = NSNumber(bool: true);
//    }
//   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

