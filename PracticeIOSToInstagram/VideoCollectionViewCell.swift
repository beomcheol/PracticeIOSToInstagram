//
//  VideoCollectionViewCell.swift
//  PracticeIOSToInstagram
//
//  Created by Masher Shin on 25/02/2017.
//  Copyright © 2017 Masher Shin. All rights reserved.
//

import UIKit
import InstagramKit

class VideoCollectionViewCell: UICollectionViewCell {
    
    var media: InstagramMedia? {
        didSet {
            webView.loadRequest(URLRequest(url: (media?.standardResolutionVideoURL)!))
            webView.scrollView.isScrollEnabled = false
            webView.scrollView.bounces = false
        }
    }
    
    @IBOutlet var webView: UIWebView!
}
