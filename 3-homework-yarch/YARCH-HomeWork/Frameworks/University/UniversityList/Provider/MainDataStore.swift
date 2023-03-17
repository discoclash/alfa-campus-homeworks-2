//
//  File.swift
//  University
//
//  Created by G on 14.01.2023.
//

import Foundation

import Foundation
// протокол для DataStore
protocol DataStoring {
    func getValue(name: String) -> UniversityModel?
    func setValue(newValue: UniversityModel)
}

final class MainDataStore: DataStoring {
    // в этой переменной будет хранится кэш
    private var data: [String: UniversityModel] = [:]
    
    // публичные методы для работы с кэшем
    func getValue(name: String) -> UniversityModel? {
        data[name]
    }
    func setValue(newValue: UniversityModel) {
        data[newValue.name] = newValue
    }
}
