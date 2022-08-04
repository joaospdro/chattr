//
//  ProfileFooter.swift
//  Chattr
//
//  Created by Joao Pedro Oliveira on 01/08/22.
//

import UIKit

protocol ProfileFooterDelegate: AnyObject {
    func handleSignOut()
}

class ProfileFooter: UIView {
    
    // MARK: - Properties
    
    weak var delegate: ProfileFooterDelegate?
    
    private lazy var signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleSignOut), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(signOutButton)
        signOutButton.anchor(left: leftAnchor, right: rightAnchor,
                             paddingLeft: 32, paddingRight: 32)
        signOutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signOutButton.centerY(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleSignOut() {
        delegate?.handleSignOut()
    }
}
