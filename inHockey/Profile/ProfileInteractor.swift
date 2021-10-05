//
//  ProfileInteractor.swift
//  inHockey
//
//  Created by Георгий on 28.09.2021.
//  
//

import Foundation
import AVFoundation

final class ProfileInteractor {
	weak var output: ProfileInteractorOutput?
    private let imageLoader = ImageLoader()
    private let database = DatabaseModel()
}

extension ProfileInteractor: ProfileInteractorInput {
    
    func uploadAvatarToDatabase(imageData: Data, completion: @escaping (Result <String, Error>) -> Void) {
        let imageLoader = ImageLoader()
        imageLoader.uploadImage(imageData) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let avatarID):
                self.database.setAvatar(avatarID: avatarID) { result in
                    switch result {
                    case .success(_):
                        completion(.success(avatarID))
                        return
                    case .failure(_):
                    completion(.failure(ImageLoader.ImageLoaderError.invalidInput))
                    return
                    }
                }
            case .failure(_):
            completion(.failure(ImageLoader.ImageLoaderError.invalidInput))
            return
            }
        }
    }
    
    func getAvatarIdFromDatabase(completion: @escaping (Result <String, Error>) -> Void) {
        database.getAvatar { result in
            switch result {
            case .success(let avatarID):
                completion(.success(avatarID))
            case .failure:
                completion(.failure(ImageLoader.ImageLoaderError.invalidInput))
                return
            }
        }
    }
    
    func getUserNameFromDatabase(completion: @escaping (Result <(String,String), Error>) -> Void) {
        database.getName { result in
            switch result {
            case .success(let name):
                completion(.success(name))
            case .failure:
                completion(.failure(ImageLoader.ImageLoaderError.unexpected))
                return
            }
        }
    }
}

