//
//  RecentMessageViewModel.swift
//  Chattr
//
//  Created by Joao Pedro Oliveira on 01/08/22.
//

import UIKit

struct RecentMessageViewModel {
    
    private let recentMessage: RecentMessage
    
    var profileImageUrl: URL? {
        return URL(string: recentMessage.user.profileImageUrl)
    }
    
    var timestamp: String {
        let date = recentMessage.message.timeStamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    
    init(recentMessage: RecentMessage) {
        self.recentMessage = recentMessage
    }
    
}
