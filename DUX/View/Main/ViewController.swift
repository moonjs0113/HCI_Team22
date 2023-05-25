//
//  ViewController.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/17.
//

import UIKit

final class ViewController: BaseViewController {
    // MARK: - Properties
    private var viewModel: ViewModel = .init()
    
    // MARK: - UI Properties
    let settingButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.init(systemName: "gear"), for: .normal)
        button.setTitle("", for: .normal)
        button.tintColor = .mainColor
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalTo: button.heightAnchor)
        ])
        return button
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .darkGray
        return imageView
    }()
    
    let nickNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Github NickName"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "@Github ID"
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    let activityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Github NickName"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    let makeGoalButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("목표 만들기", for: .normal)
        button.setTitleColor(.mainColor, for: .normal)
        button.tintColor = .mainColor
        return button
    }()
    
    let goalCollectionView: UICollectionView = {
        let flowLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 8.0
            layout.itemSize = .init(width: 200, height: 168)
            return layout
        }()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.clipsToBounds = false
        GoalCollectionViewCell.registerWithCollectionViewFromNib(collectionView)
        return collectionView
    }()
    
    // MARK: - UI Methods
    private func setupUI() {
        let imageViewBackgroundView = UIView()
        imageViewBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        imageViewBackgroundView.addSubview(imageView)
        imageViewBackgroundView.bindCircleLayout(anyCancellable: &anyCancellable)
        imageViewBackgroundView.layer.borderWidth = 1
        imageViewBackgroundView.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(imageViewBackgroundView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: imageViewBackgroundView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: imageViewBackgroundView.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: imageViewBackgroundView.heightAnchor),
            imageView.widthAnchor.constraint(equalTo: imageViewBackgroundView.widthAnchor),
            
            imageViewBackgroundView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: .layoutConstant(2)),
            imageViewBackgroundView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            imageViewBackgroundView.heightAnchor.constraint(equalTo: imageViewBackgroundView.widthAnchor),
            imageViewBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        view.addSubview(nickNameLabel)
        NSLayoutConstraint.activate([
            nickNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nickNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .layoutConstant()),
            nickNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .layoutConstant().minus),
            nickNameLabel.topAnchor.constraint(equalTo: imageViewBackgroundView.bottomAnchor, constant: .layoutConstant()),
        ])
        

//        view.addSubview(idLabel)
//        NSLayoutConstraint.activate([
//            idLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            idLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
//            idLabel.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor, constant: .layoutConstant(3)),
//        ])
        let collectionViewTitleLabel = UILabel()
        collectionViewTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionViewTitleLabel.text = "나의 목표"
        collectionViewTitleLabel.textColor = .white
        collectionViewTitleLabel.textAlignment = .left
        collectionViewTitleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        view.addSubview(collectionViewTitleLabel)
        view.addSubview(goalCollectionView)
        view.addSubview(makeGoalButton)
        NSLayoutConstraint.activate([
            makeGoalButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .layoutConstant().minus),
            makeGoalButton.bottomAnchor.constraint(equalTo: goalCollectionView.topAnchor, constant: .layoutConstant(1)),
            
            collectionViewTitleLabel.bottomAnchor.constraint(equalTo: goalCollectionView.topAnchor, constant: .layoutConstant(1)),
            collectionViewTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .layoutConstant()),
            
            goalCollectionView.heightAnchor.constraint(equalToConstant: .layoutConstant(40)), // 160
            goalCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: .layoutConstant().minus),
            goalCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .layoutConstant()),
            goalCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .layoutConstant().minus),
        ])
    }
    
    // MARK: - Methods
    private func viewBinding() {
        settingButton
            .publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                let viewController = self?.viewModel.settingViewContoller
                self?.pushViewController(viewController)
            }
            .store(in: &anyCancellable)
        
        makeGoalButton
            .publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                let viewController = self?.viewModel.setDeadlineViewContoller
                self?.pushViewController(viewController)
            }
            .store(in: &anyCancellable)
    }
    
    private func fetchCollectionView() {
//        goalCollectionView.reloadData()
    }
    
    // MARK: - Objc-C Methods
    
    // MARK: - IBOutlets
    
    // MARK: - IBActions
    
    // MARK: - Life Cycles
    override func loadView() {
        super.loadView()
        setupUI()
        addTrailingItem(item: settingButton)
        viewBinding()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCollectionView()
    }
}

