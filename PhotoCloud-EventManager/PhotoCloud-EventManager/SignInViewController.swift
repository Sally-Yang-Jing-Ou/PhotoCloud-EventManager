//
//  SignInViewController.swift
//  PhotoCloud-EventManager
//
//  Created by Sally Yang Jing Ou on 2015-03-14.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var submitButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButton (sender: UIButton!){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let mainNavigationVC = storyboard?.instantiateViewControllerWithIdentifier("MainNavigationVC") as UINavigationController

        self.presentViewController(mainNavigationVC, animated: true, completion: nil)
    }


}

