//
//  PhotosCollectionViewCell.swift
//  PhotoCollection
//
//  Created by Stephanie Ballard on 8/3/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var photo: Photo? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let photo = photo else { return }
        titleTextLabel.text = photo.title
        imageView.image = UIImage(data: photo.imageData)
    }
}
