//
//  WindowManager.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/23.
//

import UIKit

public final class WindowManager {
    static let shared: WindowManager  = .init()
    private var rootViewController: UIViewController? {
        self.window?.rootViewController
    }
    
    public var frontViewController: UIViewController? {
        UIApplication.topViewController(of: rootViewController)
    }
    
    public var window: UIWindow? {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        return windowScene?.windows.first
    }
    
    func showAlertController(title: String, message:String, addCancel: Bool = false, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "확인", style: .default) { (alertAction) in
            if let completion = completion {
                completion()
            }
        }
        alertController.addAction(acceptAction)
        
        if addCancel {
            alertController.addAction(.init(title: "취소", style: .cancel))
        }
        frontViewController?.present(alertController, animated: true, completion: nil)
    }
}
