//
//  HomesViewController.swift
//  Kitsch
//
//  Created by Ben Ashman on 2/28/16.
//  Copyright © 2016 Ben Ashman. All rights reserved.
//

import UIKit
import HomeKit

class ShowHomesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HMHomeManagerDelegate {
    
    @IBOutlet weak var homesTableView: UITableView!
    
    lazy var homeManager: HMHomeManager = {
        let manager = HMHomeManager()
        manager.delegate = self
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homesTableView.delegate = self
        homesTableView.dataSource = self
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeManager.homes.count
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let home = homeManager.homes[indexPath.row] as HMHome
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
