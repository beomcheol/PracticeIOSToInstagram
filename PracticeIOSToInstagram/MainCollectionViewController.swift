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

    @IBAction func prepareUnwindSegue(for segue: UIStoryboardSegue) {
        loadLikeMedias()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
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
                }
            }
        }
        return tags
    }
}

// MARK: UICollectionViewDataSource
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
            return header
        }
        
        return UICollectionReusableView()
    }
}

// MARK: UICollectionViewDelegate
extension MainCollectionViewController {
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
}

extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columnCount = 5
        let width = (UIScreen.main.bounds.width - CGFloat(columnCount + 1)) / CGFloat(columnCount)
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: tagsHeaderHeight == 0 ? 1 : tagsHeaderHeight)
    }
}
