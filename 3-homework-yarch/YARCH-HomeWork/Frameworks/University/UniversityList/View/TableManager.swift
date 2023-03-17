//
//  File.swift
//  University
//
//  Created by G on 14.01.2023.
//

import UIKit

// TableManager для заполнения MaimView

// Используется для передачи события при взамодействии с TableView
protocol TableManagerDelegate: AnyObject {
    func selectItem(name: String)
}

final class TableManager: NSObject {
    var universities: [String] = []
    weak var delegate: TableManagerDelegate?
}

extension TableManager: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return universities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") ?? UITableViewCell(style: .default, reuseIdentifier: "cellId")
        cell.textLabel?.text = universities[indexPath.row]
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectItem(name: universities[indexPath.row])
    }
}
