//
//  MainCollectionViewController.swift
//  PracticeIOSToInstagram
//
//  Created by Masher Shin on 25/02/2017.
//  Copyright © 2017 Masher Shin. All rights reserved.
//

import UIKit
import InstagramKit

private let reuseIdentifier = "LikedMedaCell"

class MainCollectionViewController: UICollectionViewController {
    
    var instagramMedias: [InstagramMedia] = [] {
        didSet {
            tags = makeCountedTags()
        }
    }
    
    var tags: [Tag] = []
    
    fileprivate var tagsHeaderHeight: CGFloat = 0 {
        didSet {
            if oldValue == 0 {
                collectionView?.reloadData()
            }
        }
    }
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        performSegue(withIdentifier: "AuthViewController", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mediaCollectionViewController = segue.destination as? MediaCollectionViewController {
            mediaCollectionViewController.tagName = sender as? String
        }
        
        if let detailMediaViewController = segue.destination as? DetailMediaViewController,
            let cell = sender as? LikedMedaCell {
            detailMediaViewController.instagramMedia = cell.instagramMedai
        }
    }
    
    @IBAction func prepareUnwindSegue(for segue: UIStoryboardSegue) {
        loadLikeMedias()
    }
}

// MARK: - Private
private extension MainCollectionViewController {
    func loadLikeMedias() {
        InstagramEngine.shared().getMediaLikedBySelf(success: { [weak self] instagramMedias, paginationInfo in
            self?.instagramMedias = instagramMedias
            self?.collectionView?.reloadData()
        }) { error, code in
            
        }
    }
    
    func makeCountedTags() -> [Tag] {
        var tags: [Tag] = []
        Tag.totalCount = 0
        instagramMedias.forEach { media in
            Array(media.tags as! NSArray).forEach { instagamTag in
                if let tagName = instagamTag as? String {
                    if let index = tags.index(of: Tag(name: tagName, count: 1)) {
                        var updatedTag = tags.remove(at: index)
                        updatedTag.count += 1
                        tags.append(updatedTag)
                    } else {
                        tags.append(Tag(name: tagName, count: 1))
                    }
                    Tag.totalCount += 1
                }
            }
        }
        return tags
    }
}

// MARK: - UICollectionViewDataSource
extension MainCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return instagramMedias.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LikedMedaCell
        cell.instagramMedai = instagramMedias[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LikedTagsReusableView", for: indexPath) as! LikedTagsReusableView
            header.heightUpdateClosure = { [weak self] height in
                self?.tagsHeaderHeight = height
            }
            header.tags = tags
            header.tagPreesedClosure = { [weak self] tagName in
                self?.performSegue(withIdentifier: "MediaCollectionViewController", sender: tagName)
            }
            return header
        }
        
        return UICollectionReusableView()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columnCount = 5
        let width = (UIScreen.main.bounds.width - CGFloat(columnCount + 1 + 16)) / CGFloat(columnCount)
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: tagsHeaderHeight == 0 ? 1 : tagsHeaderHeight)
    }
}
