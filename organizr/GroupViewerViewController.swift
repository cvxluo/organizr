//
//  GroupViewerViewController.swift
//  organizr
//
//  Created by Lincoln Roth on 4/14/18.
//  Copyright © 2018 phs. All rights reserved.
//

import UIKit
import FirebaseAuth

class GroupViewerViewController: UIViewController{
    
    var selectedGroup: String!
    @IBOutlet weak var name: UILabel!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        print("yall")
        name.text = selectedGroup!

    }
}
