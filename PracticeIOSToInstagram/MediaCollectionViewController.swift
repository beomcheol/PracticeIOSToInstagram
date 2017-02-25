//
//  MediaCollectionViewController.swift
//  PracticeIOSToInstagram
//
//  Created by Masher Shin on 26/02/2017.
//  Copyright © 2017 Masher Shin. All rights reserved.
//

import UIKit
import InstagramKit

class MediaCollectionViewController: UICollectionViewController {
    var tagName: String?
    var data: [InstagramMedia] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        if let tagName = tagName {
            title = tagName
            loadMediasFromTagName(with: tagName)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailMediaViewController = segue.destination as? DetailMediaViewController,
            let cell = sender as? LikedMedaCell {
            detailMediaViewController.instagramMedia = cell.instagramMedai
        }
    }
}

private extension MediaCollectionViewController {
    func loadMediasFromTagName(with tagName: String) {
        InstagramEngine.shared().getMediaWithTagName(tagName, withSuccess: { [weak self] instagramMedia, paginationInfo in
            self?.data = instagramMedia
            self?.collectionView?.reloadData()
        }) { error, code in
            
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MediaCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikedMedaCell", for: indexPath) as! LikedMedaCell
        cell.instagramMedai = data[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MediaCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columnCount = 3
        let width = (UIScreen.main.bounds.width - CGFloat(columnCount + 1)) / CGFloat(columnCount)
        return CGSize(width: width, height: width)
    }
}
