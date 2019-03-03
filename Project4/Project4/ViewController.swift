//
//  ViewController.swift
//  Project4
//
//  Created by julie on 01/03/2019.
//  Copyright © 2019 booksgit. All rights reserved.
//

import UIKit

// import needed to use the WKWebView class
import WebKit

// class ViewController: UIViewController {
// The class we created viewC extends from UIViewC AND comforms? to WKNDelegateProtocol
class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!

    override func loadView() {
        // we create an instance of the class WKWebView
        // store it as a property in webView
        webView = WKWebView()
        // delegation is a programming pattern used a lot in iOS
        // here when web navigation page is used -- links to view controller
        // not clear
        // all navigation delegate protocol are optional
        webView.navigationDelegate = self
        // it becomes the view for our navigation controller
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // creating STUFF part 1
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        //\\ \\ \\ \\ code implement bottomBar start
        // .flexspace takes as much space as possible
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        // spacer and refresh will appear as having errors until the line below is written
        toolbarItems = [progressButton, spacer, refresh]
        
        navigationController?.isToolbarHidden = false
        
        //\\ \\ \\ \\ code implement bottomBar end
        
        // add Key Value Observer. You ll have to remove it when you are done observing
        // you have to overrride the method observeValue (done below)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        

        
        // Do any additional setup after loading the view, typically from a nib.
        // ! "force unwrap"
        // because there is no string interpolation
        // you have to use HTTPS
        // 1. your have a str
        // 2. you have a URL URL(myStr)
        // 3. turn the url into a URLRequest
        // 4. Then, you can load the url!
        let url = URL(string: "https://www.hackingwithswift.com")! // URL is a specific "type"
        webView.load(URLRequest(url: url))
        // move is the web browser using swipe left, right to go back to the previous page
        webView.allowsBackForwardNavigationGestures = true
    }

     // creating STUFF part 2
    @objc func openTapped()
    {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "hackingwithswift", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "www.youtube.com/watch?v=HluANRwPyNo", style: .default, handler: openPage))
         ac.addAction(UIAlertAction(title: "xkcd.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
        
    }

     // creating STUFF part 3
    func openPage(action: UIAlertAction)
    {
        // double force unwrap (we are using optionals)
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    // Key Value Observer
    // type cast from Double to Float
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"
        {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
}

