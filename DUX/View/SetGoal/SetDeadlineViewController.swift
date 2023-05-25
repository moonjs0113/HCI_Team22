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
        let viewController = SetGoalViewController(title: "목표만들기 - 개수 선택")
        viewController.selectedDateComponent = selectedDateComponent
        return viewController
    }
    
    var selectedDateComponent: DateComponents?
    
    // MARK: - UI Properties
    private let calendarView: UICalendarView = {
        let calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.calendar = .current
        calendarView.locale = .init(identifier: "ko_KR")
        calendarView.timeZone = .init(identifier: "ko_KR")
        calendarView.calendar.firstWeekday = 1
        calendarView.visibleDateComponents = Calendar.current.dateComponents(in: .current, from: .now)
        if let endDate = Calendar.current.date(byAdding: .year, value: 1, to: .now) {
            calendarView.availableDateRange = DateInterval(start: .now, end: endDate)
        }
        calendarView.backgroundColor = .calendarBackground
        calendarView.fontDesign = .rounded
        calendarView.wantsDateDecorations = true
        calendarView.tintColor = .mainColor
        calendarView.layer.cornerRadius = 13
        return calendarView
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .disenabledButtonBackground
        button.isEnabled = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
        return button
    }()
    
    private let selectedDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "날짜를 선택해주세요."
        label.textColor = .white
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    // MARK: - UI Methods
    private func setupUI() {
        view.addSubview(calendarView)
        let singleDateSelectionDelegate = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = singleDateSelectionDelegate
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: .layoutConstant(2)),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .layoutConstant()),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .layoutConstant().minus),
        ])
        
        view.addSubview(selectedDateLabel)
        NSLayoutConstraint.activate([
            selectedDateLabel.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: .layoutConstant(2)),
            selectedDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .layoutConstant()),
            selectedDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .layoutConstant().minus),
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

extension SetDeadlineViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        selectedDateComponent = selection.selectedDate
        if let selectedDateComponent = selectedDateComponent {
            nextButton.isEnabled = true
            nextButton.backgroundColor = .mainColor
            if let year = selectedDateComponent.year,
               let month = selectedDateComponent.month,
               let day = selectedDateComponent.day {
                selectedDateLabel.text = "선택한 마감일: \(year)년 \(month)월 \(day)일"
            } else {
                selectedDateLabel.text = "날짜를 다시 선택해주세요."
            }

        } else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = .disenabledButtonBackground
            selectedDateLabel.text = "날짜를 선택해주세요."
        }
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
        return true
    }
}
