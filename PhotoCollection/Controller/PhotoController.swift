//
//  PhotoController.swift
//  PhotoCollection
//
//  Created by Stephanie Ballard on 8/3/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import Foundation

//PhotoController
//Create a swift file called "PhotoController.swift".
//Create a class PhotoController.
//Add a photos varable of type [Photo], and set its initial value to an empty array.
//Add a "Create" method that initializes a new instance of Photo and appends it to the photos array.
//Add an "Update" method that takes in Photo,Data, and String parameters.

class PhotoController {
    var photos: [Photo] = []
    
    func createPhoto(imageData: Data, title: String) {
        let newPhoto = Photo(imageData: imageData, title: title)
        photos.append(newPhoto)
    }
    
    func updatePhoto(photo: Photo, data: Data, title: String) {
        guard let updatedPhoto = photos.firstIndex(of: photo) else { return }
        photos[updatedPhoto].imageData = data
        photos[updatedPhoto].title = title
    }
}
