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
        
        let db = Firestore.firestore()
        
        let user = Auth.auth().currentUser!
        let userUID = user.uid
        
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
            db.collection("schools").document(gotSchool).collection(self.groupName.text!).document("info").setData([
                    "name": self.groupName.text!,
                    "description": self.groupDescription.text!,
                    "creator" : userUID,
                    "members" : [userUID]
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
                
                
            } else {
                print("Document does not exist")
            }
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc = storyboard.instantiateViewController(withIdentifier: "Groups")
        self.present(vc, animated: true, completion: nil)
        
 
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}


