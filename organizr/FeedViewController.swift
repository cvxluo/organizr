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
    
    @IBAction func signOutDidPress(_ sender: Any) {
        try! Auth.auth().signOut()
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
}
