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
    
    @IBOutlet weak var postName: UITextField!
    
    @IBOutlet weak var postDescription: UITextField!
    
    @IBAction func createPostPressed(_ sender: Any) {
        
        let currentDateTime = Date
        
        let db = Firestore.firestore()
        
        let user = Auth.auth().currentUser!
        let userUID = user.uid
        /*
        db.collection("users").document(userUID).getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                let gotSchool = dataDescription["school"] as! String
                var groupsAMemberOf = dataDescription["groups"] as! [String]
                groupsAMemberOf.append(self.groupName.text!)
                
                db.collection("users").document(userUID).updateData([
                    "groups": groupsAMemberOf
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
                
                
                db.collection("schools").document(gotSchool).getDocument { (document, error) in
                    if let document = document, document.exists {
                        let dataDescription = document.data()
                        print(dataDescription)
                        var gotClubs = dataDescription["clubs"] as! [String]
                        print("howdyyalllll", gotClubs)
                        
                        gotClubs.append(self.groupName.text!)
                        print("why is it all fucked up", gotClubs)
                        db.collection("schools").document(gotSchool).updateData([
                            "clubs": gotClubs
                        ]) { err in
                            if let err = err {
                                print("Error updating document: \(err)")
                            } else {
                                print("Document successfully updated")
                            }
                        }
                    }
                }
            }
        }
        
        db.collection("groups").document(self.groupName.text!).setData([
            "name": self.groupName.text!,
            "description": self.groupDescription.text!,
            "members": [userUID]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        */
        
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


