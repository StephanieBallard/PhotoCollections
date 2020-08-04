//
//  PhotoDetailViewController.swift
//  PhotoCollection
//
//  Created by Stephanie Ballard on 8/3/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import UIKit
import Photos

class PhotoDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    
    var photoController: PhotoController?
    var photo: Photo?
    var themeHelper: ThemeHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Create Photo"
        setTheme()
        updateViews()

        // Do any additional setup after loading the view.
    }
    
//    The addImage action should present a UIImagePickerController that allows the user to select an image to add to the Photo object.
//
//    Note: Unless you use an unwind, a segue always presents a new view controller each time it is called.
//    Note: Make sure you request authorization to access the photo library, and add the "Privacy - Photo Library Usage Description" key-value pair to the info.plist.
//    Note: Your PhotoDetailViewController will need to adopt both the UIImagePickerControllerDelegate and UINavigationControllerDelegate protocols and implement the didFinishPickingMediaWithInfo method to get the image the user selects, then dismiss the image picker.
    
    @IBAction func addPhotoButtonTapped(_ sender: UIButton) {
        let photoPicker = UIImagePickerController()
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch authorizationStatus {
        case .authorized:
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
            photoPicker.sourceType = .photoLibrary
            photoPicker.delegate = self
            present(photoPicker, animated: true, completion: nil)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                guard status == .authorized else {
                    print("User did not authorize access to the photo library")
                    return
                }
            }
        default:
            break
        }
    }
    
//    The "Save" bar button item's action should either update the photo if it has a value, or create a new instance of photo using the methods in the photoController. "Pop" the view controller afterwards.
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let image = imageView.image,
            let imageData = image.pngData(),
            let title = captionTextField.text else { return }
        
        if let photo = photo {
            photoController?.updatePhoto(photo: photo, data: photo.imageData, title: photo.title)
        } else {
            photoController?.createPhoto(imageData: imageData, title: title)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
//    Create an updateViews function that takes the property values of the photo object (if it isn't nil) and
//    sets them in the appropriate UI element.
//    You will need to use the UIImage(data: Data) initializer to convert the photo's imageData to a UIImage.
//    You can then put that UIImage in the image view. Call this function each time the view loads.
    
    func updateViews() {
        guard let photo = photo else { return }
        imageView.image = UIImage(data: photo.imageData)
        captionTextField.text = photo.title
        self.title = photo.title
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func setTheme() {
        guard let themePreference = themeHelper?.themePreference else { return }
        
        var backgroundColor: UIColor!
        
        switch themePreference {
        case "Dark":
            backgroundColor = .darkGray
        case "Pink":
            backgroundColor = .systemPink
        default:
            break
        }
        
        view.backgroundColor = backgroundColor
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
