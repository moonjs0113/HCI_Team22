//
//  LockScreenViewController.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/06/06.
//

import UIKit
import Combine

class LockScreenViewController: UIViewController {
    
    var anyCancellable: Set<AnyCancellable> = .init()
    
    let imageView: UIImageView = {
        let imageView = UIImageView(image: .init(named: "LockScreen"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func setupImageView() {
        self.view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        view
            .publisher(type: .tap)
            .sink { [weak self] _ in
                let transition = CATransition()
                transition.duration = 0.3
                transition.type = CATransitionType.moveIn
                transition.subtype = CATransitionSubtype.fromTop
                self?.view.window!.layer.add(transition, forKey: kCATransition)
                self?.dismiss(animated: true)
            }
            .store(in: &anyCancellable)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
