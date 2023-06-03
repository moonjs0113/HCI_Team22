//
//  GoalCollectionViewCell.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/24.
//

import UIKit

final class GoalCollectionViewCell: UICollectionViewCell {
    // MARK: - Static
    var data: Goal!
    
    static var reuseIdentifier: String {
        "\(self.self)"
    }
    
    static func registerWithCollectionViewFromNib(_ collectionView: UICollectionView) {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: self.reuseIdentifier, bundle: bundle)
        collectionView.register(nib, forCellWithReuseIdentifier: self.reuseIdentifier)
    }
    
    // MARK: - Properties
    public override var isHighlighted: Bool {
        didSet {
            let duration = isHighlighted ? 0.45 : 0.4
            let transform = isHighlighted ? CGAffineTransform(scaleX: 0.96, y: 0.96) : CGAffineTransform.identity
            let animations = {
                self.transform = transform
            }
            
            UIView.animate(
                withDuration: duration,
                delay: 0,
                usingSpringWithDamping: 1.0,
                initialSpringVelocity: 0.0,
                options: [
                    .allowUserInteraction,
                    .beginFromCurrentState
                ],
                animations: animations,
                completion: nil
            )
        }
    }
    
    // MARK: - UI Properties
    
    // MARK: - UI Methods
    
    // MARK: - Methods
    func fetchCellUI(data: Goal) {
        self.data = data
        countLabel.text = "1/\(data.count)"
        
        let dateComponents = data.deadline.toDateComponents
        if let deadlineDate = dateComponents.date {
            let distanceDay = Calendar.current.dateComponents([.day], from: .now, to: deadlineDate).day ?? 0
            dDayLabel.text = (distanceDay > 0) ? "D-\(distanceDay)" : "D-Day"
        }
        
        if let year = dateComponents.year,
           let month = dateComponents.month,
           let day = dateComponents.day {
            deadlineLabel.text = "마감일: \(year)년 \(month)월 \(day)일"
        }
    }
    
    // MARK: - Objc-C Methods
    
    // MARK: - IBOutlets
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var dDayLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    
    // MARK: - IBActions
    
    // MARK: - Life Cycles
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
