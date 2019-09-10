import WebKit

class WebViewProtocol:NSObject, WKURLSchemeHandler {
    func webView(_ webView: WKWebView, start urlSchemeTask: WKURLSchemeTask) {
        print(urlSchemeTask.request)

        let localUrl = URL(string: "ionic://localhost")!

        let response = HTTPURLResponse.init(url: localUrl, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: ["Content-Type": "text/html", "Cache-Control": "no-cache"])!
        let data = """
            <script>
                const d = JSON.stringify(Object.keys(localStorage).reduce((a, c) => {
                    a[c] = localStorage[c]
                    return a
                }, {}))
                window.webkit.messageHandlers.sendUserData.postMessage(d)
            </script>
        """.data(using: .utf8)!

        urlSchemeTask.didReceive(response)
        urlSchemeTask.didReceive(data)
        urlSchemeTask.didFinish()
    }

    func webView(_ webView: WKWebView, stop urlSchemeTask: WKURLSchemeTask) {
    }
}
