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
    
    var homeManager: HMHomeManager = HMHomeManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeManager.delegate = self
        
        homesTableView.delegate = self
        homesTableView.dataSource = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        homesTableView.reloadData()
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeManager.homes.count
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let home = homeManager.homes[indexPath.row] as HMHome
        
        cell.textLabel!.text = home.name
        
        return cell
    }
    
    // MARK: HomeManagerDelegate
    
    func homeManagerDidUpdateHomes(manager: HMHomeManager) {
        homesTableView.reloadData()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addHomeSegue" {
            let controller = segue.destinationViewController as! AddHomeViewController
            controller.homeManager = homeManager
        }
        
        super.prepareForSegue(segue, sender: sender)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
