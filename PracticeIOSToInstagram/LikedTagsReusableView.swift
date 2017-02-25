//
//  LikedTagsReusableView.swift
//  PracticeIOSToInstagram
//
//  Created by Masher Shin on 25/02/2017.
//  Copyright © 2017 Masher Shin. All rights reserved.
//

import UIKit
import TagListView

struct Tag: Equatable {
    var name: String
    var count: Int
    
    static func ==(lhs: Tag, rhs: Tag) -> Bool {
        return lhs.name == rhs.name
    }
}

class LikedTagsReusableView: UICollectionReusableView {
    
    @IBOutlet var tagListView: TagListView! {
        didSet {
            tagListView.delegate = self
        }
    }
    
    var tags: [Tag]? {
        didSet {
            tags?.forEach { tagListView.addTag($0.name) }
            if tagListView.intrinsicContentSize.height > 0 {
                heightUpdateClosure?(tagListView.intrinsicContentSize.height + 16)
            }
        }
    }
    
    var heightUpdateClosure: ((CGFloat) -> Void)?
}

extension LikedTagsReusableView: TagListViewDelegate {
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) -> Void {
        
    }
}
