//
//  MainPresenterTests.swift
//  YARCH-HomeWorkTests
//
//  Created by G on 20.01.2023.
//

import Foundation
import Quick
import Nimble

@testable import University

final class MainPresenterTests: QuickSpec {
    
    override func spec() {
        var viewControllerMock: MainDisplayLogicMock!
        var mainPresenter: MainPresenter!
        
        beforeEach {
            viewControllerMock = MainDisplayLogicMock()
            mainPresenter = MainPresenter()
            mainPresenter.viewController = viewControllerMock
        }
        
        describe(".presentFetchedList") {
            it("should call view controller for display data") {
                // when
                mainPresenter.presentFetchedList(TestData.FetchList.response)
                // then
                expect(viewControllerMock.displayFetchedListWasCalled)
                    .to(equal(1))
                expect(viewControllerMock.displayFetchedListReceivedViewModel)
                    .to(equal(TestData.FetchList.viewModel))
            }
        }
        
        describe(".displayDelectedItem") {
            it("should call view controller for display details") {
                // when
                mainPresenter.displaySelectedItem(TestData.DisplaySelectedItem.response)
                // then
                expect(viewControllerMock.displayItemDetailsWasCalled)
                    .to(equal(1))
                expect(viewControllerMock.displayItemDetailsReceivedViewModel)
                    .to(equal(TestData.DisplaySelectedItem.viewModel))
            }
        }
        
        describe(".displayError") {
            it("should call view controller for display error") {
                // when
                mainPresenter.displayError(TestData.DisplayError.response)
                // then
                expect(viewControllerMock.displayErrorWasCalled)
                    .to(equal(1))
                expect(viewControllerMock.displayErrorReceivedViewModel)
                    .to(equal(TestData.DisplayError.viewModel))
            }
        }
    }
}

// MARK: - TestData

private extension MainPresenterTests {
    enum TestData {
        static let error = URLError(.badServerResponse)
        static let universityModel = UniversityModel(name: "Any Mame", country: "Any Country", domains: ["Any Domain"])
        static let listOfUnivercities: [UniversityModel] = [universityModel]
        
        enum FetchList {
            static let response = MainDataFlow.FetchList.Responce(list: listOfUnivercities)
            static let viewModel = MainDataFlow.FetchList.ViewModel(list: response.list.compactMap { $0.name })
        }
        
        enum DisplaySelectedItem {
            static let response = MainDataFlow.SelectItem.Responce(details: universityModel)
            static let viewModel = MainDataFlow.SelectItem.ViewModel(discription: "University: \(response.details.name), country: \(response.details.country), domains: \(response.details.domains)")
        }
        
        enum DisplayError {
            static let response = MainDataFlow.Error.Response(error: error)
            static let viewModel = MainDataFlow.Error.ViewModel(message: error.localizedDescription)
        }
    }
}
