//
//  SetGoalViewController.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/24.
//

import UIKit

final class SetGoalViewController: BaseViewController {
    // MARK: - Properties
    
    
    // MARK: - UI Properties
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("완료", for: .normal)
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
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: .layoutConstant(3).minus),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .layoutConstant()),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .layoutConstant().minus),
        ])
    }
    
    // MARK: - Methods
    
    // MARK: - Objc-C Methods
    
    // MARK: - IBOutlets
    
    // MARK: - IBActions
    
    // MARK: - Life Cycles
    override func loadView() {
        super.loadView()
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
