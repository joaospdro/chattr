//
//  Message.swift
//  Chattr
//
//  Created by Joao Pedro Oliveira on 25/07/22.
//

import Firebase

struct Message {
    let text: String
    let toId: String
    let fromId: String
    let timeStamp: Timestamp!
    var user: User?
    
    let isFromCurrentUser: Bool
    
    var chatPartnerId: String {
        return isFromCurrentUser ? toId : fromId
    }
    
    init(dictionary: [String: Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.toId = dictionary["toId"] as? String ?? ""
        self.fromId = dictionary["fromId"] as? String ?? ""
        self.timeStamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        
        self.isFromCurrentUser = fromId == Auth.auth().currentUser?.uid
    }
}

struct RecentMessage {
    let user: User
    let message: Message
}
