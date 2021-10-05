//
//  SignUpModel.swift
//  inHockey
//
//  Created by Георгий on 21.09.2021.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignUpModel {
    func signUp(_ firstName: UITextField, _ secondName: UITextField, _ email: UITextField, _ password: UITextField, _ passwordAgain: UITextField, completion: @escaping (Bool?, String?) -> Void) {
        guard let nameText = firstName.text,
              let secondNameText = secondName.text,
              let emailText = email.text,
              let passwordtext = password.text,
              let passwordAgainText = passwordAgain.text,
              !nameText.isEmpty,
              !secondNameText.isEmpty,
              emailText != "",
              passwordtext != "",
              passwordAgainText != "" else {
            
            completion(false, "Oh, you forgot about something")
            return
        }
    
        Auth.auth().createUser(withEmail: emailText, password: passwordAgainText) { (user, error) in
            if error != nil || user == nil {
                completion(false, "Account has already exist")
            }
            else if self.isPasswordValid(passwordtext) == false {
                completion(false, "Your password should be at least 8 symbols, contains a special character and a number.")

            }
            
            else if passwordtext != passwordAgainText {
                completion(false, "Passwords do not match")
            }
            
            else {
                let dataBase = DatabaseModel()
                dataBase.createDatabase(firstName: nameText, secondName: secondNameText) { (result) in
                    switch result {
                    case .success:
                        completion(true,"True")
                    case .failure(let error):
                        completion(false, "Error: \(error)")
                        return
                    }
                }
            }
        }
        return
    }
    
    func isPasswordValid(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
