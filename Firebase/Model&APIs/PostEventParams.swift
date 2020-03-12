//
//  PostEventParams.swift
//  Chat
//
//  Created by Francis Jemuel Bergonia on 3/9/20.
//  Copyright © 2020 Xi Apps. All rights reserved.
//

import Foundation

struct PostEventParams {
    enum Content {
        case info(ApiInfo)
        case message(body: String, fromUserId: String)
    }

    var uuid: String
    var chatId: String
    var content: Content
}
