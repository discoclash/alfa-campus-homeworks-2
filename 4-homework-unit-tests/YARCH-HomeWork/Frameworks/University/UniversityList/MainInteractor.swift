//
//  File.swift
//  University
//
//  Created by G on 14.01.2023.
//

import Foundation

protocol MainBusinessLogic: AnyObject {
    func fetchList(_ request: MainDataFlow.FetchList.Request)
    func presentDetails(_ request: MainDataFlow.SelectItem.Request)
}

final class MainInteractor: MainBusinessLogic {
    // MARK: - Private Properties
    
    private let presenter: MainPresentationLogic
    private let provider: ProvidesMainInfo
    
    // MARK: - Initializer
    init(presenter: MainPresentationLogic, provider: ProvidesMainInfo) {
        self.presenter = presenter
        self.provider = provider
    }
    // MARK: - Main Business Logic
    
    func fetchList(_ request: MainDataFlow.FetchList.Request) {
        // Загрузка и обработка результата
        provider.fetchList { [weak presenter] responce in
            switch responce {
            case let .success(responce):
                presenter?.presentFetchedList(.init(list: responce))
            case let .failure(error):
                presenter?.displayError(.init(error: error))
            }
        }
    }
    
    func presentDetails(_ request: MainDataFlow.SelectItem.Request) {
        // Загрузка (по возможности из кэша) и обработка результата
        provider.fetchDetails(useCache: true, name: request.name) { [weak presenter] response in
            switch response {
            case let .success(model):
                if let university = model {
                    presenter?.displaySelectedItem(.init(details: university))
                } else {
                    let error = DetailsError.notFound
                    presenter?.displayError(.init(error:error))
                }
            case let .failure(error):
                presenter?.displayError(.init(error: error))
            }
        }
    }
}
