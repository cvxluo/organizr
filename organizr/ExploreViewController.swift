//
//  ExploreViewController.swift
//  organizr
//
//  Created by Lincoln Roth on 4/14/18.
//  Copyright © 2018 phs. All rights reserved.
//

//
//  GroupsViewController.swift
//  organizr
//
//  Created by Lincoln Roth on 4/14/18.
//  Copyright © 2018 phs. All rights reserved.
//


import UIKit
import FirebaseAuth
import FirebaseFirestore

class ExploreViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{
    

    
     @IBOutlet weak var tableView: UITableView!
    var groups: [String] = []
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(GroupsViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.addSubview(self.refreshControl)
    }
    
    @IBAction func signOutDidPress(_ sender: Any) {
        try! Auth.auth().signOut()
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("111")
        return self.groups.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("333")
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell3")! as UITableViewCell!
        cell.textLabel?.text = self.groups[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("222")
        print("You selected cell #\(indexPath.row)!")
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        let db = Firestore.firestore()
        
        let user = Auth.auth().currentUser!
        let userUID = user.uid
        
        
        
        db.collection("users").document(userUID).getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                print(dataDescription["school"])
                db.collection("schools").document(dataDescription["school"] as! String).getDocument { (doc, error) in
                    print(doc)
                    if let doc = doc, doc.exists{
                        print("y'all")
                        let data = doc.data()
                        print(data)
                    }
                }
                

                let groupNames = dataDescription["groups"] as! [String]
                self.groups = Array(Set(self.groups + groupNames))
                
            } else {
                print("Document does not exist")
            }
        }
        self.groups.append("Howdy")
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("testestst")
        if let destination = segue.destination as? GroupViewerViewController, let indexPath = tableView.indexPathForSelectedRow {
            print("howdy")
            print(groups[indexPath.row])
            destination.selectedGroup = groups[indexPath.row]
            print("testestste")
        }
    }
    
}
