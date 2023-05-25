//
//  ViewModel.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/17.
//

import UIKit

final class ViewModel {
    // MARK: - Properties
    var userData: User!
    
    public var settingViewContoller: UIViewController? {
        SettingViewController(title: "설정")
    }
    
    public var setDeadlineViewContoller: UIViewController? {
        SetDeadlineViewController(title: "목표만들기 - 날짜 선택")
    }
    
    // MARK: - Methods
    func fetchUI(_ view: ViewController) {
        view.imageView.getImageFromURL(userData.avatarURL)
        view.nickNameLabel.text = userData.name
//        view.idLabel.text = "@\(userData.id)"
    }
    
    // MARK: - Life Cycles
    public func viewDidLoad(_ viewController: ViewController) {
        GithubAPI.Login.requestUserInfo {
            self.userData = $0.data
            self.fetchUI(viewController)
        }
    }
}
