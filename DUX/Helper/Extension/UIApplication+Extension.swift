//
//  UIApplication+Extension.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/23.
//

import UIKit

extension UIApplication {
    //현재 Scene에서 최상위 ViewController 반환
    class func topViewController(of baseViewController: UIViewController?) -> UIViewController? {
        if let navigationController = baseViewController as? UINavigationController {
            return topViewController(of: navigationController.visibleViewController)
        }
        if let tabBarController = baseViewController as? UITabBarController,
           let selectedViewController = tabBarController.selectedViewController {
            return topViewController(of: selectedViewController)
        }
        if let presentedViewController = baseViewController?.presentedViewController {
            return topViewController(of: presentedViewController)
        }
        return baseViewController
    }
}
