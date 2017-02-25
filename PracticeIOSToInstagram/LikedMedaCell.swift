//
//  LikedMedaCell.swift
//  PracticeIOSToInstagram
//
//  Created by Masher Shin on 25/02/2017.
//  Copyright © 2017 Masher Shin. All rights reserved.
//

import UIKit
import InstagramKit
import AFNetworking

class LikedMedaCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    
    var instagramMedai: InstagramMedia? {
        didSet {
            if let imageUrl = instagramMedai?.lowResolutionImageURL {
                imageView.setImageWith(imageUrl)
            }
        }
    }
}
