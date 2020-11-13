//
//  SignUpViewController.swift
//  LoginApp
//
//  Created by 沈泽洪 on 11/6/20.
//

import UIKit
import Firebase
import SwiftSpinner

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var lblStatus: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signUpAction(_ sender: Any) {
        
        //guard let strongSelf = self else { return }
        
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
        
        Auth.auth().createUser(withEmail: email!, password: password!) { authResult, error in
            if error != nil {
                self.lblStatus.text = error?.localizedDescription
                self.txtEmail.text = ""
                self.txtPassword.text = ""
                return
            }
            
            let signupSuccessAlert = UIAlertController(title: "Account has been successfully created!", message: "", preferredStyle: .alert)
            signupSuccessAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(signupSuccessAlert, animated: true, completion: nil)
            self.lblStatus.text = ""
            return

        }
    }
}
