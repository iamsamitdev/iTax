//
//  LoginViewController.swift
//  iTAX
//
//  Created by Samit Koyom on 4/8/59.
//  Copyright © พ.ศ. 2559 Samit Koyom. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        // เช็คสถานะการล็อกอินด้วยการดูจากค่า session
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLogin:Int = prefs.integerForKey("ISLOGEDIN")
        
        if(isLogin == 1)
        {
            self.performSegueWithIdentifier("loginSegue", sender: nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLogin(sender: UIButton) {
        
        // รับค่าจากฟอร์ม
        let getUsername:NSString = txtUsername.text!
        let getPassword:NSString = txtPassword.text!
        
        if(getUsername.isEqualToString("") || getPassword.isEqualToString("") )
        {
            // แสดง Alert View แจ้งเตือน
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Not Blank field"
            alertView.message = "Please enter Username and Password"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
        }else{
            //NSLog("Login OK")
            
            // สร้างตัวแปรประเภท session ไว้เช็คสถานะการล็อกอิน
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            prefs.setObject(getUsername, forKey: "USERNAME")
            prefs.setInteger(1, forKey: "ISLOGEDIN")
            prefs.synchronize()
            
            // Redirect to other veiw
            self.performSegueWithIdentifier("loginSegue", sender: nil)
        }
        
    }


}
