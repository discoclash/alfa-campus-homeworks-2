//
//  File.swift
//  University
//
//  Created by G on 26.01.2023.
//

import Foundation

enum DetailsError: LocalizedError {
    case notFound
    
    var errorDescription: String? {
        switch self {
        case .notFound:
            return "Ошибка загрузки"
        }
    }
}
