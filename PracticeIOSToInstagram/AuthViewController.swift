//
//  AuthViewController.swift
//  PracticeIOSToInstagram
//
//  Created by Masher Shin on 25/02/2017.
//  Copyright © 2017 Masher Shin. All rights reserved.
//

import UIKit
import InstagramKit

class AuthViewController: UIViewController {

    @IBOutlet var webView: UIWebView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadRequest(URLRequest(url: InstagramEngine.shared().authorizationURL(for: .publicContent)))
    }
}

// MARK: - UIWebViewDelegate
extension AuthViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let url = request.url {
            do {
                try InstagramEngine.shared().receivedValidAccessToken(from: url)
                performSegue(withIdentifier: "MainCollectionViewController", sender: nil)
                return false
            } catch {
                print(error)
            }
        }
        
        return true
    }
}
