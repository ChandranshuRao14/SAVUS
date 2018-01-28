//
//  ViewController.swift
//  savus
//
//  Created by Krishna  Madireddy on 1/27/18.
//  Copyright © 2018 Krishna  Madireddy. All rights reserved.
//

import UIKit
import FirebaseAuth

class Launch: UIViewController
{
    @IBAction func buttonPressed(_ sender: Any)
    {
        self.performSegue(withIdentifier: "login", sender: self)
    }
    //wait for 5 seconds and go to login

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
}

