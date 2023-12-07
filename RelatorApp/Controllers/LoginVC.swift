//
//  LoginVC.swift
//  RelatorApp
//
//  Created by Pavan Pullugundla on 11/2/23.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {

    let defaults = UserDefaults.standard
    @IBOutlet weak var username: UITextField!
   static public var UsernameStatus : String!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func EnterAction(_ sender: UIButton) {
        
       
        
        if (username.text == "")
        {
            
            let alert = UIAlertController(title: "\("UNAUTHORIZED")", message: "Please Enter Username", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in}))
                   self.present(alert, animated: true, completion: {})
            
        }
        else{
            LoginVC.UsernameStatus = username.text
            
            defaults.set(LoginVC.UsernameStatus, forKey: "username")
            defaults.synchronize()
            
        }
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        username.resignFirstResponder()
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
