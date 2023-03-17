//
//  File.swift
//  University
//
//  Created by G on 14.01.2023.
//

import Foundation

// Протокол, по которому Interactor общается с Presenter'ом
protocol MainPresentationLogic: AnyObject {
    func presentFetchedList(_ response: MainDataFlow.FetchList.Responce)
    func displaySelectedItem(_ response: MainDataFlow.SelectItem.Responce)
    func displayError(_ responce: MainDataFlow.Error.Response)
}

final class MainPresenter: MainPresentationLogic {
    // MARK: - Internal Properties
    weak var viewController: MainDisplayLogic?

   //MARK: - Main Presentation Logic
    
    func presentFetchedList(_ response: MainDataFlow.FetchList.Responce) {
        let list = response.list.values.compactMap { $0.name }
        viewController?.displayFetchedList(.init(list: list))
    }
    
    func displaySelectedItem(_ response: MainDataFlow.SelectItem.Responce) {
//        let message = "University: \(response.details.name))"
//            viewController?.displayItemDetails(.init(discription: message))
    }
    
    func displayError(_ responce: MainDataFlow.Error.Response) {
        viewController?.displayError(.init(message: responce.error.localizedDescription))
    }
    
}
