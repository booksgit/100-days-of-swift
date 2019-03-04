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
    var websites = ["apple.com", "xkcd.com", "hackingwithswift.com"]

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
        
        // challenge 2 start
        //let backButton = UIBarButtonItem(barButtonSystemItem: .undo, target: webView, action: #selector(webView.goBack))
        // almost the same line as the one below but you cannot change the title
        let backButton = UIBarButtonItem(title: "Back", style: .done, target: webView, action: #selector(webView.goBack))
        let fowardButton = UIBarButtonItem(title: "Foward", style: .done, target: webView, action: #selector(webView.goForward))
        // challenge 2 done
        
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        // spacer and refresh will appear as having errors until the line below is written
        toolbarItems = [progressButton, spacer, backButton, fowardButton, refresh]
        
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
        // let url = URL(string: "https://www.hackingwithswift.com")! // URL is a specific "type"
        let url = URL(string: "https://" + websites[0])! // apple.com
        webView.load(URLRequest(url: url))
        // move is the web browser using swipe left, right to go back to the previous page
        webView.allowsBackForwardNavigationGestures = true
    }

     // creating STUFF part 2
    @objc func openTapped()
    {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        
        // refactoring
        // instead of adding all the websites one by oe we create a loop to do just that!
        for website in websites
        {
                     ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        
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
    
    // we can check which part we are displaying
    // we are creating a closure
    // thanks to that we can ask the user stuff before loading the view
    // this can be an ESCAPING CLOSURE the closure can return and be used again later and count as only one call ???
    // CLOJURE basically an anonymous func
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            // the clojure
        let url = navigationAction.request.url
        // the clojure BEGINNING
        if let host = url?.host
        {
            for website in websites
            {
                if host.contains(website)
                {
                    decisionHandler(.allow)
                    return
                }

            }
        }
        decisionHandler(.cancel)
        
        // challenge 1 Beginning
        let urlNotAllowedAlert = UIAlertController(title: "Alert", message: "You are trying to access a website that is not allowed! For your safety this website will not display onscreen.", preferredStyle: .alert)
        urlNotAllowedAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(urlNotAllowedAlert, animated: true)
        // challenge 1 End
        
    }
          // the clojure END
    
}

