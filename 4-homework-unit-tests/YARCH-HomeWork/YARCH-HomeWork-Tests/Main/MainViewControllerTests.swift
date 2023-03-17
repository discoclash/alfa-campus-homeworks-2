//
//  MainViewControllerTests.swift
//  YARCH-HomeWorkTests
//
//  Created by G on 20.01.2023.
//

import Foundation
import Quick
import Nimble

@testable import University

final class MainViewControllerTests: QuickSpec {
    
    override func spec() {
        var interactorMock: MainBusinessLogicMock!
        var routerMock: MainRoutingMock!
        var contentViewMock: DisplayMainViewMock!
        var tableManagerMock: TableManager!
        var mainViewController: MainViewController!
        
        beforeEach {
            interactorMock = MainBusinessLogicMock()
            routerMock = MainRoutingMock()
            contentViewMock = DisplayMainViewMock()
            tableManagerMock = TableManager()
            mainViewController = MainViewController(interactor: interactorMock, router: routerMock, tableManager: tableManagerMock)
            mainViewController.contentView = contentViewMock
        }
        
        describe(".loadView") {
            it("should view be equal to contentView") {
                // when
                mainViewController.loadView()
                // then
                expect(mainViewController.view).to(beIdenticalTo(contentViewMock))
            }
        }
        
        describe(".viewDidLoad") {
            it("should call interactor for fetch data") {
                // when
                mainViewController.viewDidLoad()
                // then
                expect(tableManagerMock.delegate)
                    .to(beIdenticalTo(mainViewController))
                expect(contentViewMock.startLoadingIsCalled)
                    .to(equal(1))
                expect(interactorMock.fetchListWasCalled)
                    .to(equal(1))
                expect(interactorMock.fetchListReceiveRequest)
                    .to(equal(TestData.FetchList.request))
            }
        }
        
        describe(".displayFetchedList") {
            it("should configure view") {
                // when
                mainViewController.displayFetchedList(TestData.FetchList.viewModel)
                // then
                expect(tableManagerMock.universities)
                    .to(equal(TestData.FetchList.viewModel.list))
                expect(contentViewMock.configureWasCalled)   
                    .to(equal(1))
            }
        }
        
        describe(".displayItemDetails") {
            it("should present alert with university details") {
                // when
                mainViewController.displayItemDetails(TestData.DisplayItemDetails.viewModel)
                // then
                expect(routerMock.routeToAllertWasCalled)
                    .to(equal(1))
                expect(routerMock.routeToAlertReceivedMessage)
                    .to(equal(TestData.DisplayItemDetails.viewModel.discription))
            }
        }
        
        describe(".displayError") {
            it("should present alert with error message") {
                // when
                mainViewController.displayError(TestData.Error.viewModel)
                // then
                expect(routerMock.routeToAllertWasCalled)
                    .to(equal(1))
                expect(routerMock.routeToAlertReceivedMessage)
                    .to(equal(TestData.Error.viewModel.message))
            }
        }
        
        describe(".selectItem") {
            it("should should call interactor for fetch details") {
                // when
                mainViewController.selectItem(name: TestData.DisplayItemDetails.request.name)
                // then
                expect(interactorMock.presentDetailesWasCalled)
                    .to(equal(1))
                expect(interactorMock.presentDetailesReceivedRequest)
                    .to(equal(TestData.DisplayItemDetails.request))
                
            }
        }
    }
}

// MARK: - TestData

private extension MainViewControllerTests {
    enum TestData {
        enum FetchList {
            static let request = MainDataFlow.FetchList.Request()
            static let viewModel = MainDataFlow.FetchList.ViewModel(list: ["Any University"])
        }
        
        enum DisplayItemDetails {
            static let request = MainDataFlow.SelectItem.Request(name: "Any Name")
            static let viewModel = MainDataFlow.SelectItem.ViewModel(discription: "Any Details")
        }
        
        enum Error {
            static let viewModel = MainDataFlow.Error.ViewModel(message: "Allert Message")
        }
    }
    
    
}

