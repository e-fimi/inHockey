//
//  LoadingButtonImage.swift
//  inHockey
//
//  Created by Георгий on 03.10.2021.
//

import UIKit

final class LoadingButtonImage: UIButton {
    
    private var imageID: String?
    private let imageLoader = ImageLoader()
    
    func setImage(imageID: String, completion: @escaping (Result<Void, Error>)-> Void) {
        guard !imageID.isEmpty else {
            self.setImage(UIImage(named: "defaultAvatar"), for: .normal)
            completion(.success(()))
            return
        }
        self.imageID = imageID
        imageLoader.downloadImageFromDatabase(imageID) {[weak self] result in
            guard self?.imageID == imageID else {
                return
            }
            switch result {
            case .success(let image):
                self?.setImage(image, for: .normal)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
