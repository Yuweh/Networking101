//
//  FirebaseDecodable.swift
//  Chat
//
//  Created by Francis Jemuel Bergonia on 3/9/20.
//  Copyright © 2020 Xi Apps. All rights reserved.
//

import FirebaseFirestore

protocol FirebaseDecodable {
    init?(id: String, firebaseDictionary: [String: Any])
}

extension DocumentSnapshot {
    func mapDocumentSnapshot<T>(to type: T.Type) -> T? where T: FirebaseDecodable {
        return data().flatMap { T(id: documentID, firebaseDictionary: $0) }
    }
}

extension Array where Element: DocumentSnapshot {
    func mapDocumentSnapshots<T>(toArrayOf type: T.Type) -> [T]? where T: FirebaseDecodable {
        let elements = compactMap { $0.mapDocumentSnapshot(to: type) }
        guard elements.count == count else {
            return nil
        }
        return elements
    }
}
