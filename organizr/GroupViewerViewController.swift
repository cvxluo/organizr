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
    
    @IBOutlet weak var clubDescription: UILabel!
    @IBAction func backPressed(_ sender: Any) {
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func joinClubPressed(_ sender: Any) {
        
        
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        print("yall")
        name.text = selectedGroup!

    }
}
