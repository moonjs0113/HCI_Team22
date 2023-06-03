//
//  SetGoalViewController.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/24.
//

import UIKit

final class SetGoalViewController: BaseViewController {
    // MARK: - Properties
    var selectedDateComponent: DateComponents?
    var selectedCount: Int = 1
    
    // MARK: - UI Properties
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .mainColor
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
        return button
    }()
    
    private let pickerView: UIPickerView = {
       let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.backgroundColor = .calendarBackground
        pickerView.layer.cornerRadius = 13
        return pickerView
    }()
    
    private let selectedCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "선택한 개수: 1"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    // MARK: - UI Methods
    private func setupUI() {
        view.addSubview(pickerView)
        pickerView.dataSource = self
        pickerView.delegate = self
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: .layoutConstant(2)),
            pickerView.heightAnchor.constraint(equalToConstant: .layoutConstant(50)),
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .layoutConstant()),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .layoutConstant().minus),
        ])
        
        view.addSubview(selectedCountLabel)
        NSLayoutConstraint.activate([
            selectedCountLabel.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: .layoutConstant(2)),
            selectedCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .layoutConstant()),
            selectedCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .layoutConstant().minus),
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
                guard let year = self?.selectedDateComponent?.year,
                      let month = self?.selectedDateComponent?.month,
                      let day = self?.selectedDateComponent?.day,
                      let selectedCount = self?.selectedCount else {
                    return
                }
                let message = "선택하신 목표는 \n마감일: \(year)년 \(month)월 \(day)일\n목표 Commit수: \(selectedCount)개\n입니다.\n목표를 생성하시겠습니까?"
                WindowManager
                    .shared
                    .showAlertController(
                        title: "목표 만들기",
                        message: message,
                        addCancel: true) {
                            self?.makeGoal()
                        }
            }
            .store(in: &anyCancellable)
    }
    
    private func makeGoal() {
        guard let selectedDateComponent = selectedDateComponent else {
            return
        }
        let todayDateComponent = Calendar.current.dateComponents([.year,.month,.day], from: .now)
        let goal = Goal(
            startDay: todayDateComponent.toString,
            deadline: selectedDateComponent.toString,
            count: selectedCount
        )
        PersistenceManager.shared.saveGoal(value: goal)
        self.popToRootViewController()
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

extension SetGoalViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        400
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\([Int](1...400)[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCount = [Int](1...400)[row]
        selectedCountLabel.text = "선택한 개수: \(selectedCount)"
    }
}
