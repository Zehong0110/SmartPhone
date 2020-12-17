//
//  ViewController.swift
//  LoginApp
//
//  Created by 沈泽洪 on 11/6/20.
//

import UIKit
import Firebase
import SwiftSpinner

class ViewController: UIViewController {
    
    
    @IBOutlet weak var txtEmail: UITextField!

    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var lblStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signUpAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "signUpSegue", sender: nil)
    }
    
    
    @IBAction func forgotPassworkAction(_ sender: Any) {
        self.performSegue(withIdentifier: "forgotSegue", sender: nil)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        let email=txtEmail.text
        let password=txtPassword.text
        
        if email=="" || password!.count<6 {
            lblStatus.text = "Please enter email and correct password"
            return
        }
        
        if email?.isEmail==false {
            
            lblStatus.text = "Please enter valid e-mail"
            //if don't retutn here, it will show actual errors which is better but i want customiaze errors
            return
        }
        
        SwiftSpinner.show("Logging in ...")
        
        Auth.auth().signIn(withEmail: email!, password: password!) { [weak self] authResult, error in
            SwiftSpinner.hide()
            guard let strongSelf = self else { return }
          
            if error != nil{
                strongSelf.lblStatus.text = error?.localizedDescription
                return
            }            
            self?.txtPassword.text=""
            self?.lblStatus.text=""
            self!.performSegue(withIdentifier: "loginSegue", sender: strongSelf)
        }
    }
}

