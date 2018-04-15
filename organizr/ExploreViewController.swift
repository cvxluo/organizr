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
                let gotSchool = dataDescription["school"] as! String
                let inClubs = dataDescription["groups"] as! [String]
                db.collection("schools").document(gotSchool).getDocument { (doc, error) in
                    if let doc = doc, doc.exists{
                        let data = doc.data()
                        let gotClubs = data["clubs"] as! [String]
                        print("inClubs", inClubs)
                        print("gotClubs", gotClubs)
                        
                        self.groups = Array(Set(gotClubs).subtracting(inClubs))
                        
                    }
                }
            }
            else {
                print("bad")
            }
        }
        
    
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
