//
//  ViewController.swift
//  CBarcode
//
//  Created by Se Jin Lee on 18/03/2018.
//  Copyright © 2018 Se Jin Lee. All rights reserved.
//

import UIKit

class LoginAndRegisterButtonController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
// direct the user to the register/ login menu
    
    @IBAction func RegisterClicked(_ sender: Any) {
        print("clicked register")
    }
    @IBAction func LoginClicked(_ sender: Any) {
        print("clicked Login")
    }
}

