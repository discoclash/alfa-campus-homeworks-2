//
//  MainViewController.swift
//  Pods-YARCH-HomeWork
//
//  Created by G on 12.01.2023.
//

import UIKit

// Протокол общения Presenter'а с ViewController
protocol MainDisplayLogic: AnyObject {
    // Отобразить список университетов
    func displayFetchedList(_ viewModel: MainDataFlow.FetchList.ViewModel)
    // Отобразить идетальную информацию университета
    func displayItemDetails(_ viewModel: MainDataFlow.SelectItem.ViewModel)
    // Отобразить ошибку загрузки данных
    func displayError(_ viewModel: MainDataFlow.Error.ViewModel)
}

final class MainViewController: UIViewController {
    
    // MARK: - Internal Properties
    
    lazy var contentView: DisplayMainView = MainView(delegate: viewTableManager)
    
    // MARK: - Private Properties
    
    private var viewTableManager: TableManager
    private let interactor: MainBusinessLogic
    private let router: MainRouting
    
    // MARK: - Initializer
    
    init(interactor: MainBusinessLogic, router: MainRouting, tableManager: TableManager = .init()) {
        self.viewTableManager = tableManager
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewTableManager.delegate = self
        contentView.startLoading()
        interactor.fetchList(.init())
    }
}

// MARK: - Main Display Logic

extension MainViewController: MainDisplayLogic {
    
    func displayFetchedList(_ viewModel: MainDataFlow.FetchList.ViewModel) {
        viewTableManager.universities = viewModel.list
        contentView.configurate()
    }
    
    func displayItemDetails(_ viewModel: MainDataFlow.SelectItem.ViewModel) {
        router.routeToAlert(message: viewModel.discription)
    }
    
    func displayError(_ viewModel: MainDataFlow.Error.ViewModel) {
        router.routeToAlert(message: viewModel.message)
    }
}

// MARK: - TTableManagerDelegate

extension MainViewController: TableManagerDelegate {
    func selectItem(name: String) {
        interactor.presentDetails(.init(name: name))
    }
}
