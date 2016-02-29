//
//  AddHomeViewController.swift
//  Kitsch
//
//  Created by Ben Ashman on 2/28/16.
//  Copyright © 2016 Ben Ashman. All rights reserved.
//

import UIKit
import HomeKit

class AddHomeViewController: UIViewController, HMHomeManagerDelegate {
    
    @IBOutlet weak var homeNameTextField: UITextField!
    
    var homeManager: HMHomeManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeNameTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func addHome(sender: AnyObject) {
        let homeName = homeNameTextField.text!
        
        if homeName.characters.count == 0 {
            // TODO: Handle empty field
            return
        }
        
        homeManager.addHomeWithName(homeName) { (home, error) -> Void in
            if error != nil {
                // TODO: Handle errors
                print("error: \(error)")
            } else {
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }
        }
    }
}
