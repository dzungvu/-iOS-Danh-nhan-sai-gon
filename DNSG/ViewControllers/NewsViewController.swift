//
//  NewsViewController.swift
//  DNSG
//
//  Created by The Dung on 8/5/18.
//  Copyright © 2018 The Dung. All rights reserved.
//

import UIKit
import WebKit

class NewsViewController: UIViewController, WKUIDelegate {

    var link: String = ""
    private var loadLink: URL?
    private var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string: link)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewsViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            print("link")
            decisionHandler(WKNavigationActionPolicy.cancel)
            return
        }
        print("no link")
        decisionHandler(WKNavigationActionPolicy.allow)
    }
}
