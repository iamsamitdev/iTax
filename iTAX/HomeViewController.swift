//
//  HomeViewController.swift
//  iTAX
//
//  Created by Samit Koyom on 4/8/59.
//  Copyright © พ.ศ. 2559 Samit Koyom. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var lbTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let userName = prefs.stringForKey("USERNAME")!
        
        lbTitle.text = userName
        
    }
    
    override func viewDidAppear(animated: Bool) {
        // Connect to Web API
        let urlString = "http://localhost/webapi/personal.php"
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)
        
        session.dataTaskWithURL(url!){
            (data:NSData?,response:NSURLResponse?,error:NSError?)->Void in
            
            if let responseData = data{
                do{
                   let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments)
                    
                    print(json)
                }catch{
                   print("Cannot Read Data")
                }
            }
        }.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLogout(sender: AnyObject) {
        
        // Clear Session
        let appDomain = NSBundle.mainBundle().bundleIdentifier
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
        
        // Redirect to login page
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let intialViewController = self.storyboard!.instantiateViewControllerWithIdentifier("loginStoryboard") as UIViewController
        appDelegate.window?.rootViewController = intialViewController
        appDelegate.window?.makeKeyAndVisible()
        
    }

    

}
