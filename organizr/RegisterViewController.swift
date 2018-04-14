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

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var schoolTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    typealias FinishedDownload = () -> ()

    
    @IBAction func signUpPressed(_ sender: Any) {
        
        attemptCreateUser()

        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabView")
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func attemptCreateUser () {
        
        
        
        Auth.auth().createUser(withEmail: self.emailTextField.text!,
                               password: self.passwordTextField.text!) { user, error in
                                if error == nil {
                                    Auth.auth().signIn(withEmail: self.emailTextField.text!,
                                                       password: self.passwordTextField.text!)
                                } else{
                                    let errorCode = self.errorDidWords(error!)
                                    self.errorAlert(errorCode)
                                    
                                }
        }
        while Auth.auth().currentUser == nil{
            var x = "this is so dumb"
        }

        storeUserUID()
        
    }
    
    
    func storeUserUID () {
        let user = Auth.auth().currentUser!
        let id = user.uid
        
        let db = Firestore.firestore()
        
        db.collection("users").document(id).setData([
            "name": nameTextField.text!,
            "school": schoolTextField.text!,
            "email": emailTextField.text!,
            "groups" : [String]()
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
    }
    
    func errorAlert(_ errorWords: String){
        let alert = UIAlertController(title: "Error",
                                      message:  errorWords,
                                      preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry",
                                        style: .default){ action in
                                            
        }
        alert.addAction(retryAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    func errorDidWords(_ error: Error) -> String {
        return "Error is unknown"
    }
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

