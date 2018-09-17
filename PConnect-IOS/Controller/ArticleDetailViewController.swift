//
//  ArticleDetailViewController.swift
//  PConnect-IOS
//
//  Created by 金飞 on 2018/9/14.
//  Copyright © 2018年 金飞. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore

class ArticleDetailViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    var jsContext: JSContext? = nil
    
    var detailsContent: String = ""
    
    @IBOutlet weak var webView: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        
        self.webView?.loadHTMLString("temp test", baseURL: nil)
                self.webView?.uiDelegate = self
                self.webView?.navigationDelegate = self
        
        
        
        //获取该UIWebView的javascript上下文
        //        self.jsContext = self.webView?.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as? JSContext
        self.jsContext = JSContext()
        
        let script1: NSString = try! NSString(contentsOfFile: Bundle.main.path(forResource: "html/js/showdown", ofType: "js")!, encoding: String.Encoding.utf8.rawValue)
        
        self.jsContext?.evaluateScript(script1 as String?)
        
        let func1: NSString = NSString(string: "function convert(md) {  return (new showdown.Converter()).makeHtml(md);}")
        
        self.jsContext?.evaluateScript(func1 as String?)
        
        let jsFunctionValue: JSValue = self.jsContext!.evaluateScript("convert")
        var htmlValue: String = ""
        htmlValue = jsFunctionValue.call(withArguments: [detailsContent]).toString()
        htmlValue = NSString(format: "<html><head><title>%@</title><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0\"></head><body>%@</body></html>" , "a",htmlValue) as! String
        self.webView?.loadHTMLString(htmlValue, baseURL: nil)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation==============")
        
        //这也是一种获取标题的方法。
        let titleValue : JSValue = self.jsContext!.evaluateScript("document.title")
        //更新标题
        self.navigationItem.title = titleValue.toString()
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
