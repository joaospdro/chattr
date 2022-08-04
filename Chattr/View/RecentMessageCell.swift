//
//  MessagesCell.swift
//  Chattr
//
//  Created by Joao Pedro Oliveira on 01/08/22.
//

import UIKit

class RecentMessageCell: UITableViewCell {
    
    // MARK: - Properties
    
    var recentMessage: RecentMessage? {
        didSet { configure() }
    }
    
    let profileImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    let timestampLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        label.text = "2h"
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let messageTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        selectedBackgroundView = backgroundView
        
        addSubview(profileImageView)
        profileImageView.anchor(left: leftAnchor, paddingLeft: 12)
        profileImageView.setDimensions(width: 50, height: 50)
        profileImageView.layer.cornerRadius = 50 / 2
        profileImageView.centerY(inView: self)
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, messageTextLabel])
        stack.axis = .vertical
        stack.spacing = 4
        
        addSubview(stack)
        stack.centerY(inView: profileImageView)
        stack.anchor(left: profileImageView.rightAnchor, right: rightAnchor,
                     paddingLeft: 12, paddingRight: 16)
        
        addSubview(timestampLabel)
        timestampLabel.anchor(top: topAnchor, right: rightAnchor, paddingTop: 20, paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let recentMessage = recentMessage else { return }
        let viewModel = RecentMessageViewModel(recentMessage: recentMessage)
        
        usernameLabel.text = recentMessage.user.username
        messageTextLabel.text = recentMessage.message.text
        
        timestampLabel.text = viewModel.timestamp
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
    }
}
