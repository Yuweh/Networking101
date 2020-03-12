//
//  ApiInfo.swift
//  Chat
//
//  Created by Francis Jemuel Bergonia on 3/9/20.
//  Copyright © 2020 Xi Apps. All rights reserved.
//

import Foundation

enum ApiInfo: Hashable {
    case createdChat(userId: String, name: String)
    case addedUser(whoId: String, whomId: String)
    case userLeft(userId: String)
    case renamedChat(userId: String, name: String)
}

extension ApiInfo {
    init?(firebaseInfo: FirebaseInfo) {
        switch firebaseInfo.type {
        case "createdChat":
            guard
                let userId = firebaseInfo.userId,
                let name = firebaseInfo.name
                else {
                    return nil
            }

            self = .createdChat(userId: userId, name: name)

        case "addedUser":
            guard
                let whoId = firebaseInfo.whoId,
                let whomId = firebaseInfo.whomId
                else {
                    return nil
            }

            self = .addedUser(whoId: whoId, whomId: whomId)

        case "userLeft":
            guard
                let userId = firebaseInfo.userId
                else {
                    return nil
            }

            self = .userLeft(userId: userId)

        case "renamedChat":
            guard
                let userId = firebaseInfo.userId,
                let name = firebaseInfo.name
                else {
                    return nil
            }

            self = .renamedChat(userId: userId, name: name)

        default:
            return nil
        }
    }
}
