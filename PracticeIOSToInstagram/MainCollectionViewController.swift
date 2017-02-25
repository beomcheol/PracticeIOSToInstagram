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
    
    var instagramMedias: [InstagramMedia] = []

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
}
