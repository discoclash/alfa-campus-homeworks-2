//
//  View.swift
//  Pods-YARCH-HomeWork
//
//  Created by G on 12.01.2023.
//

import UIKit
import SnapKit

// Протокол для обращения ViewController к View
protocol DisplayMainView: UIView {
    func startLoading()
    func configurate()
}

final class MainView: UIView {
    
    // MARK: - Views
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Loading..."
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.isHidden = true
        return label
    }()
    
    // MARK: - Initializer
    
    required init(delegate: UITableViewDataSource & UITableViewDelegate) {
        super.init(frame: .zero)
        configurateSubviews()
        configurateConstraints()
        tableView.dataSource = delegate
        tableView.delegate = delegate
        self.backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - DisplayMainView

extension MainView: DisplayMainView {
    func startLoading() {
        tableView.isHidden = true
        loadingLabel.isHidden = false
    }
    
    func configurate() {
        tableView.isHidden = false
        loadingLabel.isHidden = true
        tableView.reloadData()
    }
}

// MARK: - Private Methods
private extension MainView {
    func configurateSubviews() {
        addSubview(loadingLabel)
        addSubview(tableView)
    }
    
    func configurateConstraints() {
        loadingLabel.snp.makeConstraints() {
            $0.center.equalTo(self.snp.center)
        }
        
        tableView.snp.makeConstraints() {
            $0.top.bottom.trailing.leading.equalTo(safeAreaLayoutGuide)
        }
    }
}

