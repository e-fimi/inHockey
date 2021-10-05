//
//  DatabaseModel.swift
//  inHockey
//
//  Created by Георгий on 27.09.2021.
//

import Foundation
import Firebase

class DatabaseModel {
    
    let database = Firestore.firestore().collection("Users")
    
    func createDatabase(firstName: String, secondName: String, completion: @escaping (Result <String, Error>) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        let userData = User(uid: currentUser.uid, email: currentUser.email ?? "no email", name: firstName, surname: secondName)
        let data = [
            "name": userData.name,
            "uid": userData.uid,
            "surname": userData.surname,
            "email": userData.email,
            "avatar": userData.avatar,
            "teams": userData.teams] as [String: Any]
        database.document(currentUser.uid).setData(data) { error in
            let result = Result{}
            switch result {
            case .success():
                completion(.success(""))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func setAvatar (avatarID: String, completion: @escaping(Result <String, Error>) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        database.document(currentUser.uid).setData(["avatar" : avatarID], merge: true) { (error) in
            let result = Result{}
            switch result {
            case .success():
                completion(.success("ok"))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAvatar (completion: @escaping (Result<String, Error>) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        var avatarID: String = ""
        database.document(currentUser.uid).getDocument { (document, error) in
            if let document = document, document.exists {
                avatarID = document.get("avatar") as? String ?? ""
                completion(.success(avatarID))
            }
            else {
                completion(.failure(error ?? ImageLoader.ImageLoaderError.invalidInput))
            }
        }
    }
    
    func getName(completion: @escaping(Result<(String, String),Error>) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        var name: (String, String) = ("", "")
        database.document(currentUser.uid).getDocument { (document, error) in
            if let document = document, document.exists {
                name = (document.get("name") as? String ?? "", document.get("surname") as? String ?? "")
                completion(.success(name))
            }
            else {
                completion(.failure(error ?? ImageLoader.ImageLoaderError.unexpected))
            }
        }
    }
}
