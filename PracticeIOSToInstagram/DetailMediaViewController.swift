//
//  DetailMediaViewController.swift
//  PracticeIOSToInstagram
//
//  Created by Masher Shin on 26/02/2017.
//  Copyright © 2017 Masher Shin. All rights reserved.
//

import UIKit
import InstagramKit
import AFNetworking

class DetailMediaViewController: UIViewController {

    @IBOutlet var userProfileImageView: UIImageView!
    @IBOutlet var userNameButton: UIButton!
    @IBOutlet var locationNameButton: UIButton!
    @IBOutlet var mediaImageView: UIImageView!
    @IBOutlet var mediaImageViewHeightConstraint: NSLayoutConstraint!
    
    var instagramMedia: InstagramMedia?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateComponents()
    }
}

private extension DetailMediaViewController {
    func updateComponents() {
        guard let instagramMedia = instagramMedia else {
            return
        }
        if let profilePictureURL = instagramMedia.user.profilePictureURL {
            userProfileImageView.setImageWith(profilePictureURL)
        } else {
            userProfileImageView.image = nil
        }
        userNameButton.setTitle(instagramMedia.user.username, for: .normal)
        locationNameButton.setTitle(instagramMedia.locationName ?? "", for: .normal)
        mediaImageView.setImageWith(instagramMedia.standardResolutionImageURL)
        mediaImageViewHeightConstraint.constant = instagramMedia.standardResolutionImageFrameSize.height * UIScreen.main.bounds.width / UIScreen.main.bounds.height
    }
}
