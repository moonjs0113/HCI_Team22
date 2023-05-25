//
//  BaseViewController.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/17.
//

import UIKit
import Combine

class BaseViewController: UIViewController {
    // MARK: - Enum
    /// ViewController가 호출되는 함수에 따라 지정
    enum ControllerType: Int {
        case present
        case navigation
    }

    // MARK: - Properties
    var controllerType: ControllerType?
    var anyCancellable: Set<AnyCancellable> = .init()
    var backButtonTargetAction: (() -> Void)?
    var backgroundColor: UIColor = .black
    
    // MARK: - UI Properties
    private var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.tintColor = .mainColor
        return button
    }()
    
    private var controllerTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let leadingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private let trailingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    var navigationBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: - Private Methods
    private func setupNavigationBarLayout() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = backgroundColor
        navigationBar.backgroundColor = backgroundColor
        view.addSubview(navigationBar)
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 47),
        ])
        
        navigationBar.addSubview(leadingStackView)
        NSLayoutConstraint.activate([
            leadingStackView.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            leadingStackView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 20),
            leadingStackView.heightAnchor.constraint(equalToConstant: 24),
        ])
        
        navigationBar.addSubview(trailingStackView)
        NSLayoutConstraint.activate([
            trailingStackView.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            trailingStackView.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -20),
            trailingStackView.heightAnchor.constraint(equalToConstant: 24),
        ])
        
        controllerTitleLabel.text = title
        navigationBar.addSubview(controllerTitleLabel)
        NSLayoutConstraint.activate([
            controllerTitleLabel.topAnchor.constraint(equalTo: navigationBar.topAnchor),
            controllerTitleLabel.leadingAnchor.constraint(equalTo: leadingStackView.trailingAnchor, constant: 10),
            controllerTitleLabel.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor),
        ])
    }
    
    private func setupBackButton() {
        if let type = controllerType {
            var imageName = ""
            switch type {
            case .present:
                imageName = "xmark"
            case .navigation:
                imageName = "arrow.backward"
            }
            backButton.setImage(.init(systemName: imageName), for: .normal)
            backButtonTargetAction = closeViewController
            backButton.addTarget(self, action: #selector(touchUpBackButton(_:)), for: .touchUpInside)
            addLeadingItem(item: backButton)
        }
    }
    
    // MARK: - Declarative Methods
    
    /// Default: nil
    func changeClossButtonType(type: ControllerType? = nil) -> Self {
        controllerType = type
        return self
    }
    
    func addTitleIcon(imageName: String) -> Self {
        let imageView = UIImageView(image: .init(named: imageName)?.withTintColor(.black))
        imageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
        addLeadingItem(item: imageView)
        return self
    }
    
    private func closeViewController() {
        guard let controllerType = controllerType else {
            return
        }
        switch controllerType {
        case .present:
            self.dismiss(animated: true)
        case .navigation:
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Public Methods
    func addLeadingItem(item: UIView) {
        leadingStackView.insertArrangedSubview(item, at: 0)
    }
    
    func addTrailingItem(item: UIView) {
        trailingStackView.addArrangedSubview(item)
    }
    
    func setBackButtonTarget(function: @escaping () -> Void) {
        backButtonTargetAction = function
    }
    
    func pushViewController(_ viewController: UIViewController?) {
        guard let viewController = viewController else {
            return
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    
    // MARK: - Objc-C Method
    @objc func touchUpBackButton(_ sender: UIButton) {
        backButtonTargetAction?()
    }

    // MARK: - Life Cycles
    init(title: String, type: ControllerType? = .navigation) {
        self.controllerType = type
        super.init(nibName: nil, bundle: nil)
        self.title = title
        modalTransitionStyle = .coverVertical
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupNavigationBarLayout()
        setupBackButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}
