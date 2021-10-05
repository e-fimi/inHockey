//
//  ProfileProtocols.swift
//  inHockey
//
//  Created by Георгий on 28.09.2021.
//  
//

import Foundation

protocol ProfileModuleInput {
	var moduleOutput: ProfileModuleOutput? { get }
}

protocol ProfileModuleOutput: AnyObject {
}

protocol ProfileViewInput: AnyObject {
    func setupAvatar(with avatarID: String)
    func setupNameLabel(with name: (String, String))
}

protocol ProfileViewOutput: AnyObject {
    func didTapLogOutButton()
    func didTapAvatarButton()
    func didLoadView()
}

protocol ProfileInteractorInput: AnyObject {
    func uploadAvatarToDatabase(imageData: Data, completion: @escaping (Result <String, Error>) -> Void)
    func getAvatarIdFromDatabase(completion: @escaping (Result <String, Error>) -> Void)
    func getUserNameFromDatabase(completion: @escaping (Result <(String,String), Error>) -> Void)
}

protocol ProfileInteractorOutput: AnyObject {
    
}

protocol ProfileRouterInput: AnyObject {
    func logOutAndPresentingHomePage()
    func openAvatarImagePicker(completion: @escaping (Result<Data, Error>) -> Void)
}
