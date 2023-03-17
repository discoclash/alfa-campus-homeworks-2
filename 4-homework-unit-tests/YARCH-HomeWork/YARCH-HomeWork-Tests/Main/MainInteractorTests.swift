//
//  MainInteractorTests.swift
//  YARCH-HomeWorkTests
//
//  Created by G on 20.01.2023.
//

import Foundation
import Quick
import Nimble

@testable import University

final class MainInteractorTests: QuickSpec {
    
    override func spec() {
        var presenterMock: MainPresentationLogicMock!
        var providerMock: ProvidesMainInfoMock!
        var mainInteractor: MainInteractor!
        
        beforeEach {
            presenterMock = MainPresentationLogicMock()
            providerMock = ProvidesMainInfoMock()
            mainInteractor = MainInteractor(presenter: presenterMock, provider: providerMock)
        }
        
        describe(".fetchList") {
            context("when list is fetched with succesful result") {
                beforeEach {
                    providerMock.fetchListStub = .success(TestData.listOfUnivercities)
                }
                it("should call presenter for present data") {
                    //when
                    mainInteractor.fetchList(.init())
                    // then
                    expect(providerMock.fetchListWasCalled)
                        .to(equal(1))
                    expect(presenterMock.presentFetchedListWasCalled)
                        .to(equal(1))
                    expect(presenterMock.presentFetchedListReceivedResponce)
                        .to(equal(TestData.FetchList.presentListResponce))
                    expect(presenterMock.displayErrorWasCalled)
                        .to(equal(0))
                }
            }
            
            context("when list is fetched with error") {
                beforeEach {
                    providerMock.fetchListStub = .failure(TestData.error)
                }
                it("should call presenter with error") {
                    // when
                    mainInteractor.fetchList(.init())
                    // then
                    expect(providerMock.fetchListWasCalled)
                        .to(equal(1))
                    expect(presenterMock.displayErrorWasCalled)
                        .to(equal(1))
                    expect(presenterMock.displayErrorReseivedResponce?.error)
                        .to(matchError(TestData.error))
                    expect(presenterMock.presentFetchedListWasCalled)
                        .to(equal(0))
                }
            }
        }

        describe(".presentDetails") {
            context("when details is fetched with succesful result") {
                beforeEach {
                    providerMock.fetchDetailsStub = .success(TestData.universityModel)
                }
                it("should call presenter for present details") {
                    //when
                    mainInteractor.presentDetails(.init(name: TestData.universityModel.name))
                    // then
                    expect(providerMock.fetchDetailsWasCalled)
                        .to(equal(1))
                    expect(providerMock.useCache)
                        .to(equal(TestData.presentDetails.useCache))
                    expect(providerMock.universityName)
                        .to(equal(TestData.universityModel.name))
                    expect(presenterMock.displaySelectedItemWasCalled)
                        .to(equal(1))
                    expect(presenterMock.displaySelectedItemReseivedResponce)
                        .to(equal(TestData.presentDetails.presentDetailesResponce))
                    expect(presenterMock.displayErrorWasCalled)
                        .to(equal(0))
                }
            }
            
            context("when details is fetched without value") {
                beforeEach {
                    providerMock.fetchDetailsStub = .success(TestData.universityModelNotFound)
                }
                it("should call presenter for present details with not found error") {
                    //when
                    mainInteractor.presentDetails(.init(name: TestData.universityModel.name))
                    // then
                    expect(providerMock.fetchDetailsWasCalled)
                        .to(equal(1))
                    expect(providerMock.useCache)
                        .to(equal(TestData.presentDetails.useCache))
                    expect(providerMock.universityName)
                        .to(equal(TestData.universityModel.name))
                    expect(presenterMock.displayErrorWasCalled)
                        .to(equal(1))
                    expect(presenterMock.displayErrorReseivedResponce?.error)
                        .to(matchError(TestData.presentDetails.detailesError))
                    expect(presenterMock.displaySelectedItemWasCalled)
                        .to(equal(0))
                }
            }

            context("when details is fetched with error") {
                beforeEach {
                    providerMock.fetchDetailsStub = .failure(TestData.error)
                }
                it("should call presenter with error") {
                    // when
                    mainInteractor.presentDetails(.init(name: TestData.universityModel.name))
                    // then
                    expect(providerMock.fetchDetailsWasCalled)
                        .to(equal(1))
                    expect(providerMock.useCache)
                        .to(equal(TestData.presentDetails.useCache))
                    expect(providerMock.universityName)
                        .to(equal(TestData.universityModel.name))
                    expect(presenterMock.displayErrorWasCalled)
                        .to(equal(1))
                    expect(presenterMock.displayErrorReseivedResponce?.error)
                        .to(matchError(TestData.error))
                    expect(presenterMock.displaySelectedItemWasCalled)
                        .to(equal(0))
                }
            }
        }
    }
}
// MARK: - TestData

private extension MainInteractorTests {
    enum TestData {
        static let universityModel = UniversityModel(name: "Any Mame", country: "Any Country", domains: ["Any Domain"])
        static let universityModelNotFound: UniversityModel? = nil
        static let listOfUnivercities: [UniversityModel] = [universityModel]
        static let error = URLError(.badServerResponse)

        
        enum FetchList {
            //static let request = MainDataFlow.FetchList.Request()
            static let presentListResponce = MainDataFlow.FetchList.Responce(list: listOfUnivercities)
            static let presentErrorResponce = MainDataFlow.Error.Response(error: error)
        }
        
        enum presentDetails {
            static let request = MainDataFlow.SelectItem.Request(name: universityModel.name)
            static let useCache = true
            static let presentDetailesResponce = MainDataFlow.SelectItem.Responce(details: universityModel)
            static let presentErrorResponce = MainDataFlow.Error.Response(error: error)
            static let detailesError = DetailsError.notFound
        }
    }
}
