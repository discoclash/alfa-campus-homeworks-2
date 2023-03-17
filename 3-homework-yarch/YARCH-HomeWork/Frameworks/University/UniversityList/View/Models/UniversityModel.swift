//
//  File.swift
//  Pods-YARCH-HomeWork
//
//  Created by G on 12.01.2023.
//

import Foundation

struct UniversityModel: Equatable, Decodable {
    let name: String
    let country: String
    let domains: [String]
}
