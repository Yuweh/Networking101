//
//  FirebaseUser.swift
//  Chat
//
//  Created by Francis Jemuel Bergonia on 3/9/20.
//  Copyright © 2020 Xi Apps. All rights reserved.
//

import Foundation

struct FirebaseUser: Hashable {
    var id: String
    var email: String
    var name: String
}

extension FirebaseUser: FirebaseDecodable {
    init?(id: String, firebaseDictionary: [String : Any]) {
        guard
            let email = firebaseDictionary["email"] as? String,
            let name = firebaseDictionary["name"] as? String
        else {
            return nil
        }

        self.id = id
        self.email = email
        self.name = name
    }
}
