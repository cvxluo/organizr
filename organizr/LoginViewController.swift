//
//  ViewController.swift
//  organizr
//
//  Created by Charlie Luo on 4/14/18.
//  Copyright © 2018 phs. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    

    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword: UITextField!
    
    @IBAction func loginDidTouch(_ sender: Any) {
        Auth.auth().signIn(withEmail: textFieldLoginEmail.text!,
                           password: textFieldLoginPassword.text!) { (user, error) in
                            if error != nil{
                                let errorCode = self.errorDidWords(error!)
                                self.errorAlert(errorCode)
                            }else{
                                self.checkIfLogged()
                            }
        }
    }
    
    func errorDidWords(_ error: Error) -> String {
        return "Error is unknown"
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        textFieldLoginPassword.delegate = self
        textFieldLoginEmail.delegate = self
        
        hideKeyboardWhenTappedAround()
    }
    func checkIfLogged(){
        if let user = Auth.auth().currentUser {
            print("im in")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let secondViewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
            self.present(secondViewController, animated: true, completion: nil)
            
        } else {
            print("im not in")
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldLoginEmail {
            textFieldLoginPassword.becomeFirstResponder()
        }
        if textField == textFieldLoginPassword {
            textField.resignFirstResponder()
        }
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkIfLogged()
        super.viewDidAppear(animated)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
