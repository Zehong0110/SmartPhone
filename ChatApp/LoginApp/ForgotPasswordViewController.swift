//
//  ForgotPasswordViewController.swift
//  LoginApp
//
//  Created by 沈泽洪 on 11/6/20.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetPasswordAction(_ sender: Any) {
        
        let email=txtEmail.text

        if email?.isEmail==false {
            
            lblStatus.text = "Please enter valid e-mail"
            
            //if don't retutn here, it will show actual errors which is better but i want customiaze errors
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email!) { error in
            
            if error != nil {
                self.lblStatus.text = error?.localizedDescription
                self.txtEmail.text = ""
                return
            }
            
            let alert = UIAlertController(title: "Resent has been successfully sent!", message: "Check your mail to see the reset link", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.lblStatus.text = ""
            return

        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    }
}
