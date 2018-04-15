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

class CreatePostView: UIViewController, UITextFieldDelegate {
    
    var selectedGroup: String!
    
    @IBOutlet weak var postName: UITextField!
    
    @IBOutlet weak var postDescription: UITextField!
    

    @IBAction func createPostPressed(_ sender: Any) {
        
    
        
        let currentDateTime = Date()
        
        let db = Firestore.firestore()
        
        let user = Auth.auth().currentUser!
        let userUID = user.uid
        
    db.collection("groups").document(selectedGroup).collection("posts").document(String(currentDateTime.timeIntervalSinceReferenceDate)).setData([
            "name" : postName.text!,
            "description" : postDescription.text!,
            "creator" : userUID,
            "timestamp" : String(currentDateTime.timeIntervalSinceReferenceDate)
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added")
            }
        }
        
        
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedGroup)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


