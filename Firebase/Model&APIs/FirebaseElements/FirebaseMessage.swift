//
//  FirebaseMessage.swift
//  Chat
//
//  Created by Francis Jemuel Bergonia on 3/9/20.
//  Copyright © 2020 Xi Apps. All rights reserved.
//

import Foundation

struct FirebaseMessage: Hashable {
    var fromUserId: String
    var body: String
    var isRead: Bool
}

extension FirebaseMessage {
    init?(firebaseDictionary: [String: Any]) {
        guard
            let fromUserId = firebaseDictionary["fromUserId"] as? String,
            let body = firebaseDictionary["body"] as? String,
            let isRead = firebaseDictionary["isRead"] as? Bool
        else {
            return nil
        }

        self.fromUserId = fromUserId
        self.body = body
        self.isRead = isRead
    }
}
