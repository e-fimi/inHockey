//
//  ImageLoader.swift
//  inHockey
//
//  Created by Георгий on 27.09.2021.
//

import Foundation
import Firebase
import FirebaseStorage
import UIKit

class ImageLoader {
    
    enum ImageLoaderError: Error {
        case invalidInput
        case unexpected
    }
    private var imageCache: [String: UIImage] = [:]
    private let storage = Storage.storage()
    
    func uploadImage(_ imageData: Data, completion: @escaping(Result <String, Error>) -> Void) {
        guard let currentUser = Auth.auth().currentUser,
              let image = UIImage(data: imageData, scale: 1),
              let data = image.jpegData(compressionQuality: 1) else {
            completion(.failure(ImageLoaderError.invalidInput))
            return
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let randomName = UUID().uuidString
        
        storage.reference(withPath: "\(currentUser.uid)").child(randomName).putData(data, metadata: metadata) { (_,error)  in
            if let error = error {
                completion(.failure(error))
            } else {
                self.imageCache[randomName] = image
                completion(.success(randomName))
            }
        }
    }
    
    func downloadImageFromDatabase(_ imageName: String, completion: @escaping(Result <UIImage, Error>) -> Void) {
        if let image = imageCache[imageName] {
            completion(.success(image))
            return
        }
        guard let currentUser = Auth.auth().currentUser else {return}
        storage.reference(withPath: "\(currentUser.uid)").child(imageName).getData(maxSize: 15 * 1024 * 1024) { [weak self](data, error) in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data, let image = UIImage(data: data) {
                self?.imageCache[imageName] = image
                completion(.success(image))
            }
            else {
                completion(.failure(ImageLoader.ImageLoaderError.unexpected))
            }
        }
        
    }
    
}
