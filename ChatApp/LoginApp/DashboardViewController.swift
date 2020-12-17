//
//  DashboardViewController.swift
//  LoginApp
//
//  Created by 沈泽洪 on 11/6/20.
//

import UIKit
import Firebase

class DashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath)
        cell.textLabel?.text="Zehong Shen"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Show chat messages
        let vc=ChatViewController()
        vc.title="Chat"
        navigationController?.pushViewController(vc, animated:true)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.delegate=self
        myTable.dataSource=self
        myTable.register(UITableViewCell.self, forCellReuseIdentifier:"cell")
        

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var myTable: UITableView!
    @IBAction func logoutAction(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            self.navigationController?.popViewController(animated: true)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
            
        }
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
