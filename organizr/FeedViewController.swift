//
//  ViewController.swift
//  organizr
//
//  Created by Charlie Luo on 4/14/18.
//  Copyright © 2018 phs. All rights reserved.
//

import UIKit
import FirebaseAuth

class FeedViewController: UIViewController, UITextFieldDelegate {
    
    @IBAction func logOutDidPressed(_sender: Any){
        try! Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
