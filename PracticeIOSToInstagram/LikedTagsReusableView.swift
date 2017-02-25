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
    
    static var totalCount: Int = 0
}

class LikedTagsReusableView: UICollectionReusableView {
    
    @IBOutlet var tagListView: TagListView! {
        didSet {
            tagListView.delegate = self
        }
    }
    
    var tags: [Tag]? {
        didSet {
            tags?.forEach {
                let alpha = CGFloat($0.count) / (CGFloat(Tag.totalCount) * 0.1)
                tagListView.addTag($0.name).borderColor = UIColor.init(white: 0, alpha: alpha)
            }
            if tagListView.intrinsicContentSize.height > 0 {
                heightUpdateClosure?(tagListView.intrinsicContentSize.height + 16)
            }
        }
    }
    
    var heightUpdateClosure: ((CGFloat) -> Void)?
    
    var tagPreesedClosure: ((String) -> Void)?
}

extension LikedTagsReusableView: TagListViewDelegate {
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) -> Void {
        tagPreesedClosure?(title)
    }
}
