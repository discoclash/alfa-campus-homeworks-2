//
//  File.swift
//  Pods-YARCH-HomeWork
//
//  Created by G on 12.01.2023.
//

import Foundation

protocol NetworkServicing: AnyObject {
    associatedtype Responce = Decodable
    func fetchList(completion: @escaping (Result<[Responce], Error>) -> Void)
}

final class AnyNetworkService<T: Decodable>: NetworkServicing {
    typealias Responce = T
    private let fetchListMethod: (@escaping (Result<[Responce], Error>) -> Void) -> Void
    
    init<C: NetworkServicing>(_ concrete: C) where C.Responce == T {
        fetchListMethod = concrete.fetchList
    }
    
    func fetchList(completion: @escaping (Result<[Responce], Error>) -> Void) {
        fetchListMethod(completion)
    }
}

final class UniversityListService: NetworkServicing {
    typealias Responce = UniversityModel

    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder
    
    init(urlSession: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.urlSession = urlSession
        self.jsonDecoder = decoder
    }
    
    func fetchList(completion: @escaping (Result<[Responce], Error>) -> Void) {
        let uri = "http://universities.hipolabs.com/search?name=middle&country=United%20States"
        guard let url = URL(string: uri) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard
                    let data = data,
                    let decodedData = try? self?.jsonDecoder.decode([Responce].self, from: data)
                else {
                    completion(.failure(URLError(.badServerResponse)))
                    return
                }
                
                completion(.success(decodedData))
            }
        }
        
        dataTask.resume()
    }
}
