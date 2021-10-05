//
//  ProfilePresenter.swift
//  inHockey
//
//  Created by Георгий on 28.09.2021.
//  
//

import Foundation

final class ProfilePresenter {
	weak var view: ProfileViewInput?
    weak var moduleOutput: ProfileModuleOutput?

	private let router: ProfileRouterInput
	private let interactor: ProfileInteractorInput

    init(router: ProfileRouterInput, interactor: ProfileInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ProfilePresenter: ProfileModuleInput {
}

extension ProfilePresenter: ProfileViewOutput {
    
    func didLoadView() {
        reloadAvatar()
        reloadName()
    }
    
    func didTapLogOutButton() {
        router.logOutAndPresentingHomePage()
    }
    
    func reloadAvatar (){
        interactor.getAvatarIdFromDatabase { [weak self] result in
            switch result {
            case.success(let avatarID):
                self?.view?.setupAvatar(with: avatarID)
            case .failure(_):
                return
            }
        
        }
    }
    
    func reloadName() {
        interactor.getUserNameFromDatabase { [weak self] result in
            switch result {
            case .success(let name):
                self?.view?.setupNameLabel(with: name)
            case .failure(_):
                return
            }
        }
    }
    
    func didTapAvatarButton() {
        router.openAvatarImagePicker {[weak self] result  in
            switch result {
            case .success(let data):
                self?.interactor.uploadAvatarToDatabase(imageData: data) {[weak self] result in
                    switch result {
                    case .success(_):
                        self?.reloadAvatar()
                    return
                    case .failure(_):
                        return
                    }
                    
                }
            case .failure(_):
                return
            }
        }
    }
}

extension ProfilePresenter: ProfileInteractorOutput {
}
