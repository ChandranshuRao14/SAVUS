//
//  Login.swift
//  savus
//
//  Created by Krishna  Madireddy on 1/27/18.
//  Copyright © 2018 Krishna  Madireddy. All rights reserved.
//

import UIKit

class Login: UIViewController {

    @IBAction func caPressed(_ sender: Any)
    {
        self.performSegue(withIdentifier: "signup", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
