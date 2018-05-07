//
//  LoginViewController.swift
//  CBarcode
//
//  Created by Se Jin Lee on 18/03/2018.
//  Copyright © 2018 Se Jin Lee. All rights reserved.
//
import UIKit
import Firebase
import SCLAlertView
import TextFieldEffects
class LoginViewController: UIViewController {
    
    @IBOutlet weak var IDText: KaedeTextField!
    @IBOutlet weak var PasswordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginClicked(_ sender: Any) {
    
        Auth.auth().signIn(withEmail: IDText.text!, password: PasswordText.text!, completion: { (user, error) in
            if error != nil {
                // shows warning when the user has given wrong info
                 SCLAlertView().showInfo("Wrong email or password", subTitle: "please try again")
            }else
            {
                // login successful. move to the main menu
                self.performSegue(withIdentifier: "toMenu", sender: self)
            }
        })
    }
}

