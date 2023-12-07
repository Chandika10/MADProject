//
//  ProfileVC.swift
//  RelatorApp
//
//  Created by Pavan Pullugundla on 11/2/23.
//

import UIKit

class ProfileVC: UIViewController {
    @IBOutlet weak var Username: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let savedUsername = UserDefaults.standard.string(forKey: "username") {
            print("Username: \(savedUsername)")
            Username.text =  "Hello" + " " + savedUsername
        } else {
          
            print("No username found")
        }
    }
    
    @IBAction func Favorite(_ sender: Any) {
        
    }
    
   
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "username")
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
