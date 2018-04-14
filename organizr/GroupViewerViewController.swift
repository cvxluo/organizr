//
//  GroupViewerViewController.swift
//  organizr
//
//  Created by Lincoln Roth on 4/14/18.
//  Copyright © 2018 phs. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class GroupViewerViewController: UIViewController{
    
    var selectedGroup: String!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var clubDescription: UILabel!
    @IBAction func backPressed(_ sender: Any) {
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func joinClubPressed(_ sender: Any) {
        
        let db = Firestore.firestore()
        
        let user = Auth.auth().currentUser!
        let userUID = user.uid
        
        db.collection("users").document(userUID).getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                let gotSchool = dataDescription["school"] as! String
                var groupsAMemberOf = dataDescription["groups"] as! [String]
                groupsAMemberOf.append(self.selectedGroup)
                
                db.collection("users").document(userUID).updateData([
                    "groups": groupsAMemberOf
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
                db.collection("schools").document(gotSchool).collection(self.selectedGroup).document("info").getDocument { (document, error) in
                        if let document = document, document.exists {
                            let dataDescription = document.data()
                            var groupMembers = dataDescription["members"] as! [String]
                            groupMembers.append(userUID)
                            
                        db.collection("schools").document(gotSchool).collection(self.selectedGroup).document("info").updateData([
                                "members": groupMembers
                            ]) { err in
                                if let err = err {
                                    print("Error updating document: \(err)")
                                } else {
                                    print("Document successfully updated")
                                }
                            }
                
                
            } else {
                print("Document does not exist")
            }
        }
            }
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc = storyboard.instantiateViewController(withIdentifier: "TabView")
        self.present(vc, animated: true, completion: nil)
        
    }
        
    
    override func viewDidLoad(){
        super.viewDidLoad()
        name.text = selectedGroup!
        

    }
}
