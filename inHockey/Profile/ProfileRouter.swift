//
//  ProfileRouter.swift
//  inHockey
//
//  Created by Георгий on 28.09.2021.
//  
//

import UIKit

final class ProfileRouter {
    weak var viewController: UIViewController?
}

extension ProfileRouter: ProfileRouterInput {
    
    func logOutAndPresentingHomePage() {
        UserDefaults.standard.setValue(false, forKeyPath: "isAuth")
        let authViewController = AuthViewController()
        authViewController.modalPresentationStyle = .fullScreen
        self.viewController?.present(authViewController, animated: true, completion: nil)
    }
    
    func openAvatarImagePicker(completion: @escaping (Result<Data, Error>) -> Void) {
        let imagePickerController = ImagePickerController()
        imagePickerController.showAvatarImagePicker(in: viewController) { result in
            imagePickerController.dismiss(animated: true)
            switch result {
            case .success(let data):
                imagePickerController.dismiss(animated: true)
                completion(.success(data))
            case .failure(_):
                imagePickerController.dismiss(animated: true)
                return
            }
        }
    }
}
