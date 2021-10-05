//
//  ImagePickerController.swift
//  inHockey
//
//  Created by Георгий on 27.09.2021.
//

import UIKit

final class ImagePickerController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    private var completion: ((Result<Data, Error>) -> Void)?
    
    func showAvatarImagePicker(in viewController: UIViewController?, completion: @escaping (Result<Data, Error>) -> Void) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.completion = completion
        viewController?.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.editedImage] as? UIImage else {
            self.dismiss(animated: true)
            self.completion?(.failure(ImageLoader.ImageLoaderError.invalidInput))
            return
        }
        let data = image.jpegData(compressionQuality: 1)
        guard let data1 = data else {
            self.dismiss(animated: true)
            self.completion?(.failure(ImageLoader.ImageLoaderError.invalidInput))
            return
        }
        self.completion?(.success(data1))

    }
}
