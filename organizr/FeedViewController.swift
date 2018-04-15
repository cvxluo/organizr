//
//  GroupFeedViewController.swift
//  organizr
//
//  Created by Lincoln Roth on 4/14/18.
//  Copyright © 2018 phs. All rights reserved.
//


import UIKit
import FirebaseAuth
import FirebaseFirestore

class FeedViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{
    
    var selectedGroup: String!
    var i = 0
    
    @IBOutlet weak var tableView: UITableView!
    var groups = [[String: Any]]()
    
    @IBAction func signOutDidPress(_ sender: Any) {
        
        try! Auth.auth().signOut()
        self.navigationController?.dismiss(animated: true, completion: nil)
        
    }
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(GroupsViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .none

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.addSubview(self.refreshControl)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("2111")
        return self.groups.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("2333")
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell6")! as UITableViewCell
        cell.textLabel?.text = self.groups[indexPath.row]["name"] as! String
        cell.textLabel!.font = UIFont.systemFont(ofSize: 24)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("3222")
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
                let userClubs = dataDescription["groups"] as! [String]
                print("userclubs", userClubs)
                
                var allPostNames = [[String: Any]]()
                
                for club in userClubs {
                    db.collection("groups").document(club).collection("posts").getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            for document in querySnapshot!.documents {
                                var postData = document.data()
                                postData["group"] = club
                                allPostNames.append(postData)
                                self.groups = allPostNames
                                self.tableView.reloadData()
                                refreshControl.endRefreshing()
                                
                            }
                        }
                    }
                }
                
            }
        }
        
        //self.tableView.reloadData()
        //refreshControl.endRefreshing()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        

        let navVC = segue.destination as? UINavigationController
        
        if let groupfeed = navVC?.viewControllers.first as? PostViewController{
            
            groupfeed.selectedPost = groups[(tableView.indexPathForSelectedRow?.row)!]["timestamp"] as! String
            groupfeed.selectedGroup = groups[(tableView.indexPathForSelectedRow?.row)!]["group"] as! String
        }
    }
    
    
}
