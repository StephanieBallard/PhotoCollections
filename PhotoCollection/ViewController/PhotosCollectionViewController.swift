//
//  PhotosCollectionViewController.swift
//  PhotoCollection
//
//  Created by Stephanie Ballard on 8/3/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {

    let photoController = PhotoController()
    let themeHelper = ThemeHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTheme()
    }
    
    func setTheme() {
        guard let themePreference = themeHelper.themePreference else { return }
        
        var backgroundColor: UIColor!
        
        switch themePreference {
        case "Dark":
            backgroundColor = .darkGray
        case "Pink":
            backgroundColor = .systemPink
        default:
            break
        }
        
        collectionView.backgroundColor = backgroundColor
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        The segue from the cell should pass the themeHelper, photoController, and the photo.
//        The segue from the "Add" bar button item should pass the the themeHelper and the photoController.
//        The segue from the "Select Theme" bar button item should pass the themeHelper.
        switch segue.identifier {
        case "SelectThemeModalSegue":
            guard let destinationViewController = segue.destination as? ThemeSelectionViewController else { return }
            destinationViewController.themeHelper = themeHelper
        case "AddPhotoShowSegue":
            guard let destinationViewController = segue.destination as? PhotoDetailViewController else { return }
            destinationViewController.photoController = photoController
            destinationViewController.themeHelper = themeHelper
        case "PhotoDetailShowSegue":
            guard let destinationViewController = segue.destination as? PhotoDetailViewController else { return }
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            destinationViewController.photoController = photoController
            destinationViewController.themeHelper = themeHelper
            destinationViewController.photo = photoController.photos[indexPath.item]
        default:
            break
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photoController.photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
    
        let photo = photoController.photos[indexPath.item]
        cell.photo = photo
    
        return cell
    }
}
