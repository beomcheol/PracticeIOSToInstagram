//
//  AuthViewController.swift
//  PracticeIOSToInstagram
//
//  Created by Masher Shin on 24/02/2017.
//  Copyright © 2017 Masher Shin. All rights reserved.
//

import UIKit
import InstagramKit

class AuthViewController: UIViewController {

    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadRequest(URLRequest(url: InstagramEngine.shared().authorizationURL(for: .publicContent)))
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

extension AuthViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let url = request.url {
            do {
                try InstagramEngine.shared().receivedValidAccessToken(from: url)
                performSegue(withIdentifier: "MainCollectionViewController", sender: nil)
            } catch {
                print(error)
            }
        }
        
        return true
    }
}
