//
//  VCBase.swift
//  RevelryTest
//
//  Created by Babul on 23/08/16.
//  Copyright © 2016 Babul. All rights reserved.
//

import UIKit

class VCBase: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var tableArr:[String] = []
    @IBOutlet weak var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cellIdentifier";
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier);
        
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier);
        }
        return cell!;
        
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableArr.count;
    }
    

}
