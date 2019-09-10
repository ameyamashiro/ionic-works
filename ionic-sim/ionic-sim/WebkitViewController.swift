import UIKit
import WebKit

class WebkitViewController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = WKWebViewConfiguration()
        config.setURLSchemeHandler(WebViewProtocol(), forURLScheme: "ionic")
        let contentController = WKUserContentController()
        
        contentController.add(self, name: "sendUserData")
        config.userContentController = contentController

        let wkWebView = WKWebView(frame: view.frame, configuration: config)
        let url = URL(string: "ionic://localhost")!
        let urlRequest = URLRequest(url: url)

        wkWebView.load(urlRequest)
        
        view.addSubview(wkWebView)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "sendUserData" {
            print(message.body)
        }
    }
}
