//
//  File.swift
//  University
//
//  Created by G on 14.01.2023.
//

import Foundation

enum MainDataFlow {
    
    enum FetchList {
        // Загружает данные экрана
        struct Request: Equatable {}
        struct Responce: Equatable {
            let list: [UniversityModel]
        }
        struct ViewModel: Equatable {
            let list: [String]
        }
    }
    
    // Отображает деталей университета
    enum SelectItem {
        struct Request {
            let name: String
        }
        struct Responce {
            let details: UniversityModel?
        }
        struct ViewModel {
            let discription: String
        }
    }
    
    // Отображает ошибку загрузки данных
    enum Error {
        struct Response {
            let error: Swift.Error
        }
        struct ViewModel: Equatable {
            let message: String
        }
    }
}
