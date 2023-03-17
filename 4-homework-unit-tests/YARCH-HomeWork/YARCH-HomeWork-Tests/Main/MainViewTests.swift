//
//  MainViewTests.swift
//  YARCH-HomeWorkTests
//
//  Created by G on 20.01.2023.
//

import Foundation
import Quick
import Nimble

@testable import University

final class MainViewTests: QuickSpec {
    override func spec() {
        var tableManagerMock: TableManager!
        var tableViewMock: TableViewMock!
        var mainView: MainView!
                
        beforeEach {
            tableManagerMock = TableManager()
            tableViewMock = TableViewMock()
            mainView = MainView(delegate: tableManagerMock)
            mainView.tableView = tableViewMock
        }
        
        describe(".startLoading") {
            it("call when view starts loading and waiting for data") {
                // when
                mainView.startLoading()
                // then
                expect(mainView.tableView.isHidden).to(equal(true))
                expect(mainView.loadingLabel.isHidden).to(equal(false))
            }
        }
        
        describe(".configurate") {
            it("call for configuring view") {
                // when
                mainView.configurate()
                // then
                expect(mainView.tableView.isHidden).to(equal(false))
                expect(mainView.loadingLabel.isHidden).to(equal(true))
                expect(tableViewMock.reloadDataWasCalled)
                    .to(equal(1))
            }
        }
    }
}
