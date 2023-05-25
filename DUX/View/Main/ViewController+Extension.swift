//
//  ViewController+Extension.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/25.
//

import UIKit

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        PersistenceManager.shared.getGoals()?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GoalCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? GoalCollectionViewCell else {
            return .init()
        }
        if let goalList = PersistenceManager.shared.getGoals() {
            cell.fetchCellUI(data: goalList[indexPath.row])
        }
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.clipsToBounds = true
        return cell
    }
    
    
}
