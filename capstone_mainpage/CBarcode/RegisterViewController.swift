//
//  RegisterViewController.swift
//  CBarcode
//
//  Created by Se Jin Lee on 18/03/2018.
//  Copyright © 2018 Se Jin Lee. All rights reserved.
//
import UIKit
import TextFieldEffects
import Firebase
import SCLAlertView
class RegisterViewController: UIViewController {
    
    @IBOutlet weak var IDText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func registerButton(_ sender: Any) {
        Auth.auth().createUser(withEmail: IDText.text!, password: passwordText.text!, completion: { (user, error) in
            if error != nil {
                // shows warning when the user has given email address which already exists in the data base
                SCLAlertView().showInfo("This email has already been registered", subTitle: "register with a different email")
            }
            else
            {
                // register successful, move to the main menu
                self.performSegue(withIdentifier: "toMenu", sender: self)
                
                
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

