//
//  GroupsViewController.swift
//  organizr
//
//  Created by Lincoln Roth on 4/14/18.
//  Copyright © 2018 phs. All rights reserved.
//


import UIKit
import FirebaseAuth

class GroupsViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
   
    
    var groups: [String] = ["PHSCRC", "SciOly", "I Lunch"]
    
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
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell2")! as UITableViewCell!
        cell.textLabel?.text = self.groups[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("222")
        print("You selected cell #\(indexPath.row)!")
        tableView.deselectRow(at: indexPath, animated: true)
        
    }


    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
    
        groups.append("More Clubs")
        
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
