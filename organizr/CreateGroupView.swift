//
//  ViewController.swift
//  organizr
//
//  Created by Charlie Luo on 4/14/18.
//  Copyright © 2018 phs. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class CreateGroupView: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var groupName: UITextField!
    
    @IBOutlet weak var groupDescription: UITextField!
    
    @IBAction func createGroupPressed(_ sender: Any) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}


