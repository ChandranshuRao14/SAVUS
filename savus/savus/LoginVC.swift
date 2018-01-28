//
//  LoginVC.swift
//  savus
//
//  Created by Krishna  Madireddy on 1/28/18.
//  Copyright © 2018 Krishna  Madireddy. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    @IBAction func loginPressed(_ sender: Any)
    {
        if emailField.text != "" && passField.text != ""
        {
            Auth.auth().signIn(withEmail: emailField.text!, password: passField.text!, completion:
            { (user, error) in
                if user != nil
                {
                    self.performSegue(withIdentifier: "home", sender: self) //success
                }
                else
                {
                    Auth.auth().createUser(withEmail: self.emailField.text!, password: self.passField.text!, completion:
                    { (usr, err) in
                        if usr != nil
                        {
                            self.performSegue(withIdentifier: "home", sender: self) //success
                        }
                        
                        else
                        {
                            print ("ERROR")
                        }
                    })
                }
            })
        }
        
        else
        {
            print ("Please fill out all the information!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 10
        loginButton.clipsToBounds = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
