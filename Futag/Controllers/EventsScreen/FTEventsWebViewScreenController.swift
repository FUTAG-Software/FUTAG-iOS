//
//  FTEventsWebViewScreenController.swift
//  Futag
//
//  Created by Furkan Erdoğan on 26.02.2022.
//

import Foundation
import UIKit
import WebKit

class FTEventsWebViewScreenController: UIViewController {
    
    //MARK: - Properties
    
    var selectedLink: String?
    
    private lazy var webView: WKWebView = {
        let web = WKWebView()
        
        
        return web
    }()
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configureUI()
        webView.navigationDelegate = self
        
    }
    
    //MARK: - API
    
    
    //MARK: - Selector
    
    
    
    //MARK: - Helper
    
    func configureUI() {
        
        view.addSubview(webView)
        webView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        let url = URL(string: self.selectedLink ?? "")
            webView.load(URLRequest(url: url!))
        
    }
    
    
    

    

}

extension FTEventsWebViewScreenController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finished navigating to url \(webView.url)")

    }
    
}
