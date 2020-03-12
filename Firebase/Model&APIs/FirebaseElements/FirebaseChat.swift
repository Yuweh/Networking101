//
//  FirebaseChat.swift
//  Chat
//
//  Created by Francis Jemuel Bergonia on 3/9/20.
//  Copyright © 2020 Xi Apps. All rights reserved.
//

import FirebaseFirestore

struct FirebaseChat: Hashable {
    var id: String
    var name: String
    var userIds: [String]
    var createdAt: Date
    var latestMessage: FirebaseMessage?
}

extension FirebaseChat: FirebaseDecodable {
    init?(id: String, firebaseDictionary: [String: Any]) {
        guard
            let name = firebaseDictionary["name"] as? String,
            let userIds = firebaseDictionary["userIds"] as? [String],
            let createdAt = firebaseDictionary["createdAt"] as? Timestamp,
            let rawLatestMessage = firebaseDictionary["latestMessage"] as? [String: Any]?
        else {
            return nil
        }

        self.id = id
        self.name = name
        self.userIds = userIds
        self.createdAt = createdAt.dateValue()
        self.latestMessage = rawLatestMessage.flatMap(FirebaseMessage.init)
    }
}
