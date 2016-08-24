//
//  VCBase.swift
//  RevelryTest
//
//  Created by Babul on 23/08/16.
//  Copyright © 2016 Babul. All rights reserved.
//

import UIKit
import CoreData


class VCBase: UIViewController,UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate,CellProtocol {

    var cancelableObjects : [NSIndexPath] = []
    var managedObjectContext: NSManagedObjectContext = CoreDataController.sharedInstance.managedObjectContext;
    var tableArr:[String] = []
    var predicate : NSPredicate!
    @IBOutlet weak var tableView:UITableView!
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest(entityName: "StateDataEntity")
        
        // Add Sort Descriptors
     
        fetchRequest.sortDescriptors = []
        fetchRequest.predicate = self.predicate;
        // Initialize Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: -
    // MARK: Fetched Results Controller Delegate Methods
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }

    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch (type) {
        case .Insert:
            if let indexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            break;
        case .Delete:
            if let indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            break;
        default :
            break;
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cellIdentifier";
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! TableViewCell;
        let record = fetchedResultsController.objectAtIndexPath(indexPath) as! StateDataEntity;
      
        cell.delegate = self;
        cell.titleLabel.text = record.name;
        cell.cancelButton.hidden = !self.cancelableObjects.contains(indexPath);
        return cell;
        
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: false);
         let obj  = self.fetchedResultsController.objectAtIndexPath(indexPath);
        let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! TableViewCell;
        cell.changeState(obj as! StateDataEntity )
        cell.cancelButton.hidden = false;
        self.cancelableObjects.append(indexPath);
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let trash = UITableViewRowAction(style: .Normal, title: "Trash") { action, index in
            let obj  = self.fetchedResultsController.objectAtIndexPath(indexPath);
            
            CoreDataController.sharedInstance.deleteObject(obj as! StateDataEntity);
           
        }
        trash.backgroundColor = UIColor.orangeColor();
        
        return [trash]
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        
        
        
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // you need to implement this method too or you can't swipe to display the actions
        
        
        
    }
    
    func cancelButtonTapped(cell : TableViewCell) {
        
        let indexPath = self.tableView.indexPathForCell(cell);
        self.cancelableObjects.removeAtIndex(self.cancelableObjects.indexOf(indexPath!)!);
    }
    

}

protocol CellProtocol {
    func cancelButtonTapped(cell : TableViewCell) ;
}
public class TableViewCell : UITableViewCell {
    
    @IBOutlet weak var titleLabel : UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    var timer : NSTimer!
    var delegate : CellProtocol?
    func changeState(obj : StateDataEntity ) {
        self.timer  = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector:  #selector(TableViewCell.confirmChangeState(_:)), userInfo: ["StateDataEntity" : obj], repeats: false)
    }
    
    @IBAction func cancelButtonClicked(sender : UIButton) {
        self.timer.invalidate();
        self.timer = nil;
        self.cancelButton.hidden = true;
        self.delegate?.cancelButtonTapped(self);
    }
    
    func confirmChangeState(timer :  NSTimer)  {
         self.delegate?.cancelButtonTapped(self);
       let obj = timer.userInfo!["StateDataEntity"] as! StateDataEntity;
        
        obj.state = NSNumber(bool: !(obj.state?.boolValue)!);
        try!CoreDataController.sharedInstance.managedObjectContext.save()
        self.cancelButton.hidden = true;
        

    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clearColor()
        ;
        self.tintColor = UIColor.clearColor();
        self.contentView.backgroundColor = UIColor.clearColor()
        self.cancelButton.backgroundColor = UIColor.orangeColor().colorWithAlphaComponent(0.8);
        self.selectionStyle = .None
       
    }
    public override func prepareForReuse() {
        super.prepareForReuse()
        self.cancelButton.hidden = true;
    }
    
}
