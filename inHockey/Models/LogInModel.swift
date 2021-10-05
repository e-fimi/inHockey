//
//  LogInModel.swift
//  inHockey
//
//  Created by Георгий on 21.09.2021.
//

import Foundation
import FirebaseAuth

class LogInModel {
    func logIn(_ emailField: UITextField, _ passwordField: UITextField, completion: @escaping (Bool?, String?) -> Void) {
        guard let email = emailField.text,
              let password = passwordField.text,
              email != "", password != "" else {
            completion(false, "Empty email or password")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            guard user != nil else {
                completion(false, "Incorrect email or password")
                return
            }
            completion(true, "Success")
        }
        return
    }
}
