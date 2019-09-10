//
//  ViewController.swift
//  ionic-sim-2
//
//  Created by Yamashiro on 2019/06/14.
//  Copyright © 2019 Yamashiro. All rights reserved.
//

import UIKit
import GCDWebServer
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let webServer = GCDWebServer()
        webServer.addDefaultHandler(forMethod: "GET", request: GCDWebServerRequest.self, processBlock: {request in
            return GCDWebServerDataResponse(html:"""
                <html><body></body></html>
            """)
        })
        
        webServer.start(withPort: 8080, bonjourName: "GCD Web Server")
        
        print("Visit \(String(describing: webServer.serverURL)) in your web browser")
        
        let webView = WKWebView(frame: self.view.frame)
        webView.navigationDelegate = self
        webView.load(URLRequest(url: URL(string: "http://localhost:8080/")!))
        self.view.addSubview(webView)
        print("Evaluate before")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Evaluate")
        webView.evaluateJavaScript("""
            JSON.stringify(Object.keys(localStorage).reduce((a, c) => {
                a[c] = localStorage[c]
                return a
            }, {}))
        """, completionHandler: { (html: Any?, error: Error?) in
            print(html!)
        })
    }
}
