//
//  SetDeadlineViewController.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/24.
//

import UIKit

final class SetDeadlineViewController: BaseViewController {
    // MARK: - Properties
    public var setGoalViewContoller: UIViewController? {
        SetGoalViewController(title: "목표만들기 - 개수 선택")
    }
    
    // MARK: - UI Properties
    private let calendarView: UICalendarView = {
        let calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.calendar = .current
        calendarView.locale = .init(identifier: "ko_KR")
        calendarView.timeZone = .init(identifier: "ko_KR")
        calendarView.calendar.firstWeekday = 1
//        calendarView.backgroundColor = .darkGray
        // Setting the visible date and range
        calendarView.visibleDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian),
                                                    year: 2023, month: 11, day: 10)
        let fromDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian),
                                                year: 2023, month: 11, day: 5)
        let toDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian),
                                              year: 2023, month: 12, day: 15)
        
        if let fromDate = fromDateComponents.date, let toDate = toDateComponents.date {
            let calendarViewDateRange = DateInterval(start: fromDate, end: toDate)
            calendarView.availableDateRange = calendarViewDateRange
        }
        calendarView.setVisibleDateComponents(fromDateComponents, animated: true)
        calendarView.fontDesign = .rounded
        calendarView.wantsDateDecorations = true
        calendarView.tintColor = .mainColor
        calendarView.layer.cornerRadius = 13
        // let singleDateSelectionDelegate = UICalendarSelectionSingleDate(delegate: self)
//        view.selectionBehavior = multiDateSelectionDelegate
//        view.delegate = self
        return calendarView
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("다음", for: .normal)
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
        view.addSubview(calendarView)
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: .layoutConstant(1).minus),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .layoutConstant()),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .layoutConstant().minus),
        ])
        
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: .layoutConstant(3).minus),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .layoutConstant()),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .layoutConstant().minus),
        ])
    }
    
    // MARK: - Methods
    private func viewBinding() {
        nextButton
            .publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                let viewController = self?.setGoalViewContoller
                self?.pushViewController(viewController)
            }
            .store(in: &anyCancellable)
    }
    
    // MARK: - Objc-C Methods
    
    // MARK: - IBOutlets
    
    // MARK: - IBActions
    
    // MARK: - Life Cycles
    override func loadView() {
        super.loadView()
        setupUI()
        viewBinding()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
