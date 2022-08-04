//
//  MessagesViewController.swift
//  Chattr
//
//  Created by Joao Pedro Oliveira on 23/07/22.
//

import UIKit
import Firebase

private let reuseIdentifier = "MessagesCell"

class MessagesViewController: UIViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    private var recentMessages = [RecentMessage]()
    private var recentMessagesDictionary = [String: RecentMessage]()
    
    private lazy var newMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.imageView?.setDimensions(width: 24, height: 24)
        button.addTarget(self, action: #selector(showNewMessage), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        authenticateUser()
        fetchRecentMessages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar(withTitle: "Messages", prefersLargeTitle: true)
    }
    
    // MARK: - Selectors
    
    @objc func showProfile() {
        let controller = ProfileController(style: .insetGrouped)
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    @objc func showNewMessage() {
        let controller = NewMessageController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    // MARK: - API
    
    func fetchRecentMessages() {
        showLoader(true)
        
        Service.shared.fetchRecentMessages { recentMessages in
            self.recentMessages = recentMessages
            
            recentMessages.forEach { recentMessage in
                let message = recentMessage.message
                self.recentMessagesDictionary[message.chatPartnerId] = recentMessage
            }
            
            self.showLoader(false)
            
            self.recentMessages = Array(self.recentMessagesDictionary.values)
            self.tableView.reloadData()
        }
    }
    
    func authenticateUser() {
        if Auth.auth().currentUser?.uid == nil {
            presentSignInScreen()
        }
    }
    
    func signOutUser() {
        do {
            try Auth.auth().signOut()
            presentSignInScreen()
        } catch {
            print("DEBUG: Error signing out..")
        }
    }
    
    // MARK: - Helpers
    
    func presentSignInScreen() {
        DispatchQueue.main.async {
            let controller = SignInViewController()
            controller.delegate = self
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            nav.modalTransitionStyle = .crossDissolve
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        configureNavigationBar(withTitle: "Messages", prefersLargeTitle: true)
        configureTableView()
        
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
        
        view.addSubview(newMessageButton)
        newMessageButton.setDimensions(width: 56, height: 56)
        newMessageButton.layer.cornerRadius = 56/2
        newMessageButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                                paddingBottom: 16, paddingRight: 24)
    }
    
    func configureTableView() {
        tableView.backgroundColor = .white
        tableView.rowHeight = 80
        tableView.register(RecentMessageCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
    
    func showChatController(forUser user: User) {
        let controller = ChatController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - MessagesViewControllerDataSource

extension MessagesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! RecentMessageCell
        cell.recentMessage = recentMessages[indexPath.row]
        return cell
    }
}

// MARK: - MessagesViewControllerDelegate

extension MessagesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = recentMessages[indexPath.row].user
        showChatController(forUser: user)
        
    }
}

// MARK: - NewMessageControllerDelegate

extension MessagesViewController: NewMessageControllerDelegate {
    func controller(_ controller: NewMessageController, wantsToStartChatWith user: User) {
        dismiss(animated: true, completion: nil)
        showChatController(forUser: user)
    }
}

extension MessagesViewController: ProfileControllerDelegate {
    func handleSignOut() {
        signOutUser()
    }
}

// MARK: - AuthDelegate

extension MessagesViewController: AuthDelegate {
    func authComplete() {
        dismiss(animated: true, completion: nil)
        configureUI()
        fetchRecentMessages()
    }
}
