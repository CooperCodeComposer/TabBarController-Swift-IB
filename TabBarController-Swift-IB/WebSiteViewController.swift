//
//  WebSiteViewController.swift
//  TabBarController-Swift-IB
//
//  Created by Alistair Cooper on 5/3/16.
//  Copyright © 2016 Alistair Cooper. All rights reserved.
//

import UIKit
import WebKit

class WebSiteViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!  //NOTE: When you set a delegate you need to conform to the protocol
    var progressView: UIProgressView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .Plain, target: self, action: #selector(WebSiteViewController.openTapped))
        
        progressView = UIProgressView(progressViewStyle: .Default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .Refresh, target: webView, action: #selector(UIWebView.reload))
        
        // this is the array in UIToolBar
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.toolbarHidden = false
        
        let url = NSURL(string: "http://www.imdb.com")!
        webView.loadRequest(NSURLRequest(URL: url))
        webView.allowsBackForwardNavigationGestures = true
        
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)
        
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
            // NOTE estimatedProgress is a Double. UIProgressView progress is a Float.
        }
    }
    
    func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .ActionSheet)
        ac.addAction(UIAlertAction(title: "apple.com", style: .Default, handler: openPage))
        ac.addAction(UIAlertAction(title: "mozilla.org", style: .Default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
        
    }
    
    func openPage(action: UIAlertAction!) {
        let url = NSURL(string: "https://" + action.title!)!
        webView.loadRequest(NSURLRequest(URL: url))
    }

    // NOTE disabled as it changes the icon name also
//    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
//        title = webView.title
//        
//    }
    
    func refreshTapped() {
        // NOTE WKWebView has a reload method
        webView.reload()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
