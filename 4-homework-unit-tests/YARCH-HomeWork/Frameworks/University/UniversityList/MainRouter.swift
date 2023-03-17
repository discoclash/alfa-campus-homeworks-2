//
//  File.swift
//  University
//
//  Created by G on 14.01.2023.
//

import Foundation
// Распределение Маршрутизации
protocol MainRouting {
    func routeToAlert(message: String)
}

final class MainRouter: MainRouting {
    // MARK: - Internal Properties
    weak var viewController: UIViewController?
    
    // MARK: - Main Routing
    func routeToAlert(message: String) {
        let alertController = UIAlertController(
            title: nil,
            message: message,
            preferredStyle: .alert)
        viewController?.present(alertController, animated: true)
    }
}
