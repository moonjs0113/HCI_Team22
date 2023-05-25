//
//  LoginViewController.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/17.
//

import UIKit

final class LoginViewController: BaseViewController {
    // MARK: - Properties
    
    
    // MARK: - UI Properties
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Github Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .mainColor
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
        return button
    }()
    // MARK: - UI Methods
    private func setupUI() {
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: .layoutConstant(3).minus),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .layoutConstant()),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .layoutConstant().minus),
        ])
    }
    
    // MARK: - Methods
    private func viewBinding() {
        loginButton
            .publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                self?.touchUpLoginButton()
            }
            .store(in: &anyCancellable)
    }
    
    private func touchUpLoginButton() {
        GithubAPI.Login.requestOAuthCode()
//        let baseURLString = "https://github.com/login/oauth/authorize"
//        let requestManager = RequestManager(baseURL: baseURLString)
//        let parameter = [
//            "client_id" : clientID,
//            "scope" : scope,
//        ]
        
//        let clientID = "e3f5b6b0fa067208e4e7"
//        let scope = "repo_deployment"
//        let authURLString = "\(baseURLString)?client_id=\(clientID)&scope=\(scope)"
//        guard let authURL = URL(string: authURLString) else { return }
//        UIApplication.shared.open(authURL)
    }
    
    // MARK: - Objc-C Methods
    
    // MARK: - IBOutlets
    
    // MARK: - IBActions
    
    // MARK: - Life Cycles
    override func loadView() {
        super.loadView()
        setupUI()
        viewBinding()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

}
