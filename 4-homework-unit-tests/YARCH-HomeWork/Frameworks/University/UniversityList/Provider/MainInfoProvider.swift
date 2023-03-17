//
//  File.swift
//  University
//
//  Created by G on 14.01.2023.
//

import Foundation

// Протокол, через который  Interactor обращается к Provider
protocol ProvidesMainInfo: AnyObject {
    func fetchList(completion: @escaping (Result<UniversityModel, Error>) -> Void)
    func fetchDetails(useCache: Bool, name: String, completion: @escaping (Result<UniversityModel?, Error>) -> Void)
}

// Провайдер для интерактора
final class MainInfoProvider: ProvidesMainInfo {
    
    //private var cache: DataStoring
    private let service: AnyNetworkService<UniversityModel>
    
    init(service: AnyNetworkService<UniversityModel>) {
        self.service = service
    }
    
    func fetchDetails(useCache: Bool, name: String, completion: @escaping (Result<UniversityModel?, Error>) -> Void) {
//        if useCache {
//            // проверяем есть ли в кеше запрашиваемый университет
//            guard cache.getValue(name: name) == nil else {
//                completion(.success(cache.getValue(name: name)))
//                return
//            }
//            // если в кеше искомого университета нет, то идём в сеть
//        }
//        // ищем в массиве моделей исомую модель
//        service.fetchList() { result in
//            switch result {
//            case let .success(responce):
//                if let i = responce.firstIndex(where: { $0.name == name}) {
//                    completion(.success(responce[i]))
//                } else {
//                    // если и сети нет искомого университет, то возвращаем nil (мог оформит в виде ошибки, но решл упростить)
//                    completion(.success(nil))
//                }
//            case let .failure(error):
//                completion(.failure(error))
//            }
//        }
    }
    
    func fetchList(completion: @escaping (Result<UniversityModel, Error>) -> Void) {
        service.fetchList { result in
            completion(result)
        }
    }
}
