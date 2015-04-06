//
//  SignInViewController.swift
//  PhotoCloud-EventManager
//
//  Created by Sally Yang Jing Ou on 2015-03-14.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var okayButton: UIButton?
    @IBOutlet weak var passwordTextField: UITextField?
    
    let passwordConstant = "passwordKey"
    var readPassword: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        readPassword = NSUserDefaults.standardUserDefaults().stringForKey(passwordConstant)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        readPassword = NSUserDefaults.standardUserDefaults().stringForKey(passwordConstant)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func okayButton (sender: UIButton!){
        var passwordText = passwordTextField?.text
        
        if (readPassword == nil){
            if (passwordText != "") {
                NSUserDefaults.standardUserDefaults().setObject(passwordText, forKey: passwordConstant)
                NSUserDefaults.standardUserDefaults().synchronize()
            }
            else {
                var alert = UIAlertView(title: "Set Up Password", message: "Please set up your password", delegate: nil, cancelButtonTitle: "Cancel")
                alert.show()
            }
            
        } else if (passwordText == readPassword) {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let mainNavigationVC = storyboard?.instantiateViewControllerWithIdentifier("MainNavigationVC") as UINavigationController
            
            self.presentViewController(mainNavigationVC, animated: true, completion: nil)
        } else {
            var alert = UIAlertView(title: "Wrong Password!", message: "Please enter the correct password", delegate: nil, cancelButtonTitle: "Cancel")
            alert.show()
        }

        
        
        }


}

