//
//  DetailViewController.swift
//  TabBarController-Swift-IB
//
//  Created by Alistair Cooper on 5/3/16.
//  Copyright © 2016 Alistair Cooper. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    var url:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = url {
             webView.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
            
        } else  {
            url = "http://www.imdb.com"
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
