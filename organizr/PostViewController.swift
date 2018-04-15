//
//  PostViewController.swift
//  organizr
//
//  Created by Lincoln Roth on 4/14/18.
//  Copyright © 2018 phs. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class PostViewController: UIViewController, UITextFieldDelegate {
    
    var selectedPost: String!
    var selectedGroup: String!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func backDidPress(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("what", selectedPost)
        print("who", selectedGroup)

        let db = Firestore.firestore()
        
        let user = Auth.auth().currentUser!
        let userUID = user.uid
        
        let docRef = db.collection("groups").document(selectedGroup).collection("posts").document(selectedPost)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                
                print("Document data: \(document.data())")
                self.nameLabel.text! = document.data()["name"] as! String
                self.timestampLabel.text! = document.data()["timestamp"] as! String
                self.descriptionLabel.text! = document.data()["description"] as! String
            } else {
                print("Document does not exist")
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

