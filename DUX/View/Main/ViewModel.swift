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
    var commitData: Int = 0
    public var settingViewContoller: UIViewController? {
        SettingViewController(title: "설정")
    }
    
    public var setDeadlineViewContoller: UIViewController? {
        SetDeadlineViewController(title: "목표만들기 - 마감 날짜 선택")
    }
    
    // MARK: - Methods
    func fetchUI(_ view: ViewController) {
        view.imageView.getImageFromURL(userData.avatarURL)
        view.nickNameLabel.text = userData.name
        let commits = commitData
        view.commitLabel.text = "\(commits) 개의 커밋"
        if(commits >= 1 && commits < 2){
            view.tierLabel.text = "BRONZE"
            view.tierLabel.textColor = .brown
        }else if(commits >= 2 && commits < 3){
            view.tierLabel.text = "SILVER"
            view.tierLabel.textColor = .gray
        }else if(commits >= 3 && commits < 4){
            view.tierLabel.text = "GOLD"
            view.tierLabel.textColor = .yellow
        }
//        view.idLabel.text = "@\(userData.id)"
    }
    
    // MARK: - Life Cycles
    public func viewDidLoad(_ viewController: ViewController) {
        GithubAPI.Login.requestUserInfo {
            self.userData = $0.data
            GithubAPI.Login.requestRepoInfo {
                $0.map({
                    GithubAPI.Login.requestCommitInfo(userName: self.userData.name, repoName: $0.name!) {
                        self.commitData += $0.data.owner.reduce(0, +)
                        self.fetchUI(viewController)
                    }
                })
            }
        }
        
    }
}
