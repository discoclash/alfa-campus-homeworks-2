//
//  MainFactory.swift
//  Pods-YARCH-HomeWork
//
//  Created by G on 12.01.2023.
//

import Foundation

public protocol DataContext {}

public struct MainContext: DataContext {
    public init() {}
}

// Фабрика, создающая сущности и инжектирующая завимости
public struct MainFactory<Context: DataContext> {
    public init() {}
    public func build(with context: Context) -> UIViewController {
      let service = UniversityListService()
        let provider = MainInfoProvider(service: AnyNetworkService(service))
        
        let presenter = MainPresenter()
        let interactor = MainInteractor(presenter: presenter, provider: provider)
        let router = MainRouter()
        let viewController = MainViewController(interactor: interactor, router: router)
        
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
