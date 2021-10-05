//
//  User.swift
//  inHockey
//
//  Created by Георгий on 27.09.2021.
//

import Foundation
import Firebase

struct User {
    var uid: String
    var email: String
    var avatar: String = ""
    var teams: [String] = []
    var name: String
    var surname: String
    
    init(uid : String, email : String, name : String, surname : String) {
        self.uid = uid
        self.email = email
        self.name = name
        self.surname = surname
    }
}
