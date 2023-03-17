//
//  File.swift
//  Pods-YARCH-HomeWork
//
//  Created by G on 12.01.2023.
//

import Foundation

struct UniversityModel: Codable, Equatable {
    let values: [Value]
}

// MARK: - Value
struct Value: Codable,Equatable {
    let id: String
    let iconURL: String
    let name, company: String
    let amount: Amount
    let profit: Double
}

// MARK: - Amount
struct Amount: Codable,Equatable {
    let value: Int
    let currency: String
    let minorUnits: Int
}
