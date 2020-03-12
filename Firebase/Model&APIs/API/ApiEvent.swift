//
//  ApiEvent.swift
//  Chat
//
//  Created by Francis Jemuel Bergonia on 3/9/20.
//  Copyright © 2020 Xi Apps. All rights reserved.
//

import Foundation

struct ApiEvent: Hashable {
    enum Content: Hashable {
        case info(ApiInfo)
        case message(FirebaseMessage)
    }

    var id: String
    var chatId: String
    var createdAt: Date
    var content: Content
}

extension ApiEvent {
    init?(firebaseEvent: FirebaseEvent) {
        self.id = firebaseEvent.id
        self.chatId = firebaseEvent.chatId
        self.createdAt = firebaseEvent.createdAt

        switch firebaseEvent.type {
        case "info":
            guard let firebaseInfo = firebaseEvent.info, let info = ApiInfo(firebaseInfo: firebaseInfo) else {
                return nil
            }
            self.content = .info(info)

        case "message":
            guard let message = firebaseEvent.message else {
                return nil
            }
            self.content = .message(message)

        default:
            return nil
        }
    }
}

