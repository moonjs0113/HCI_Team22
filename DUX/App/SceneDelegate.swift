//
//  SceneDelegate.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/17.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    var homeViewController: UIViewController {
        ViewController(title: "")
            .changeClossButtonType()
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        self.window = UIWindow(windowScene: windowScene)
        let rootViewController: UIViewController = {
            PersistenceManager.shared.getUserToken() != nil
            ? homeViewController
            : LoginViewController(title: "")
                .changeClossButtonType()
        }()
        let rootNavigationViewController = UINavigationController(rootViewController: rootViewController)
        window?.rootViewController = rootNavigationViewController
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if url.absoluteString.starts(with: "dux://") {
                if let code = url.absoluteString.split(separator: "=").last.map(String.init) {
                    GithubAPI.Login.requestAccessToken(code: code) { result in
                        switch result {
                        case .success(let data):
                            let tokenDTO = try? JSONDecoder().decode(TokenDTO.self, from: data)
                            guard let token = tokenDTO?.data else {
                                return
                            }
                            PersistenceManager.shared.saveUserToken(value: token.access_token)
                            WindowManager
                                .shared
                                .frontViewController?
                                .present(self.homeViewController, animated: true)
                        case .failure(_):
                            WindowManager
                                .shared
                                .showAlertController(
                                    title: "로그인 오류",
                                    message: "로그인에 실패하였습니다.\n다시 시도해주시기 바랍니다."
                                )
                        }
                    }
                }
            }
        }
    }
}

