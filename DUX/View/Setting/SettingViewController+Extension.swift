//
//  SettingViewController+Extension.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/23.
//

import UIKit

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SettingType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)") else {
            return .init()
        }
        var content = cell.defaultContentConfiguration()
        content.text = SettingType.allCases[indexPath.row].title
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        cell.setHighlighted(true, animated: true)

        return cell
    }
}
