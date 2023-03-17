//
//  File.swift
//  YARCH-HomeWorkTests
//
//  Created by G on 19.01.2023.
//

import UIKit

@testable import University

final class MainBusinessLogicMock: MainBusinessLogic {
    private(set) var fetchListWasCalled = 0
    private(set) var fetchListReceiveRequest: MainDataFlow.FetchList.Request?
    
    func fetchList(_ request: University.MainDataFlow.FetchList.Request) {
        fetchListWasCalled += 1
        fetchListReceiveRequest = request
    }
    
    private(set) var presentDetailesWasCalled = 0
    private(set) var presentDetailesReceivedRequest: MainDataFlow.SelectItem.Request?
    
    func presentDetails(_ request: University.MainDataFlow.SelectItem.Request) {
        presentDetailesWasCalled += 1
        presentDetailesReceivedRequest = request
    }
}

final class MainPresentationLogicMock: MainPresentationLogic {
    private(set) var presentFetchedListWasCalled = 0
    private(set) var presentFetchedListReceivedResponce: MainDataFlow.FetchList.Responce?
    
    func presentFetchedList(_ response: University.MainDataFlow.FetchList.Responce) {
        presentFetchedListWasCalled += 1
        presentFetchedListReceivedResponce = response
    }
    
    private(set) var displaySelectedItemWasCalled = 0
    private(set) var displaySelectedItemReseivedResponce: MainDataFlow.SelectItem.Responce?
    
    func displaySelectedItem(_ response: University.MainDataFlow.SelectItem.Responce) {
        displaySelectedItemWasCalled += 1
        displaySelectedItemReseivedResponce = response
    }
    
    private(set) var displayErrorWasCalled = 0
    private(set) var displayErrorReseivedResponce: MainDataFlow.Error.Response?
    
    func displayError(_ responce: University.MainDataFlow.Error.Response) {
        displayErrorWasCalled += 1
        displayErrorReseivedResponce = responce
    }
}

final class MainDisplayLogicMock: MainDisplayLogic {
    private(set) var displayFetchedListWasCalled = 0
    private(set) var displayFetchedListReceivedViewModel: MainDataFlow.FetchList.ViewModel?
    
    func displayFetchedList(_ viewModel: University.MainDataFlow.FetchList.ViewModel) {
        displayFetchedListWasCalled += 1
        displayFetchedListReceivedViewModel = viewModel
    }
    
    private(set) var displayItemDetailsWasCalled = 0
    private(set) var displayItemDetailsReceivedViewModel: MainDataFlow.SelectItem.ViewModel?
    
    func displayItemDetails(_ viewModel: University.MainDataFlow.SelectItem.ViewModel) {
        displayItemDetailsWasCalled += 1
        displayItemDetailsReceivedViewModel = viewModel
    }
    
    private(set) var displayErrorWasCalled = 0
    private(set) var displayErrorReceivedViewModel: MainDataFlow.Error.ViewModel?
    
    func displayError(_ viewModel: University.MainDataFlow.Error.ViewModel) {
        displayErrorWasCalled += 1
        displayErrorReceivedViewModel = viewModel
        
    }
}

final class DisplayMainViewMock: UIView, DisplayMainView {
    private(set) var startLoadingIsCalled = 0
    
    func startLoading() {
        startLoadingIsCalled += 1
    }
   
    private(set) var configureWasCalled = 0
    
    func configurate() {
        configureWasCalled += 1
    }
}

final class MainRoutingMock: MainRouting {
    private(set) var routeToAllertWasCalled = 0
    private(set) var routeToAlertReceivedMessage: String?
    
    func routeToAlert(message: String) {
        routeToAllertWasCalled += 1
        routeToAlertReceivedMessage = message
    }
}

final class ProvidesMainInfoMock: ProvidesMainInfo {
    private(set) var fetchListWasCalled = 0
    var fetchListStub: Result<[UniversityModel], Error>?
    
    func fetchList(completion: @escaping (Result<[UniversityModel], Error>) -> Void) {
        fetchListWasCalled += 1
        fetchListStub.map { completion($0) }
    }
    
    private(set) var fetchDetailsWasCalled = 0
    private(set) var universityName: String?
    private(set) var useCache: Bool = false
    var fetchDetailsStub: Result<UniversityModel?, Error>?
    func fetchDetails(useCache: Bool, name: String, completion: @escaping (Result<University.UniversityModel?, Error>) -> Void) {
        fetchDetailsWasCalled += 1
        universityName = name
        self.useCache = useCache
        fetchDetailsStub.map {completion($0)}
    }
}

final class NetworkServicingMock: NetworkServicing {
    typealias Responce = UniversityModel
    
    private(set) var getWasCalled = 0
    var getComplitionStub: Result<[Responce], Error>?
    
    func fetchList(completion: @escaping (Result<[Responce], Error>) -> Void) {
        getWasCalled += 1
        getComplitionStub.map { completion($0) }
    }
}

final class TableViewMock: UITableView {
    private(set) var reloadDataWasCalled = 0
    
    override func reloadData() {
        super.reloadData()
        reloadDataWasCalled += 1
    }
}
