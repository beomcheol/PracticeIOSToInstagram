//
//  MainCollectionViewController.swift
//  PracticeIOSToInstagram
//
//  Created by Masher Shin on 24/02/2017.
//  Copyright © 2017 Masher Shin. All rights reserved.
//

import UIKit
import InstagramKit

private let reuseIdentifier = "Cell"

class MainCollectionViewController: UICollectionViewController {
    
    var medias: [InstagramMedia] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        if InstagramEngine.shared().accessToken == nil {
            performSegue(withIdentifier: "AuthViewController", sender: nil)
        }
    }

    // MARK: - Navigation
    
    /*

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        requestTag()
    }
    
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return medias.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! VideoCollectionViewCell
    
        cell.media = medias[indexPath.row]
    
        return cell
    }

    // MARK: UICollectionViewDelegate

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

private extension MainCollectionViewController {
    func requestTag() {
        InstagramEngine.shared().getMediaWithTagName("cooking", withSuccess: { [weak self] media, paginationInfo in
            
            let mm = media.filter { md in
                md.isVideo
            }
            
            for _ in 0...10 {
                self?.medias.append(contentsOf: mm)
            }
            
            self?.collectionView?.reloadData()
        }, failure: { error, statueCode in
            print(error)
        })
    }
}


extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
    }
}
