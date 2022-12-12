//
//  NetworkService.swift
//  School-Adidevtechnologies
//
//  Created by Vladislav on 11.12.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    typealias Scools = [[String: String]]
    
    func getAllSchools(offset: Int, completion: @escaping (Scools?, Error?) -> Void)
    func getAdditionalInformation(dbn: String, completion: @escaping ([SchoolAdditionalInformationNetworkModel]?, Error?) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    private let decoder = JSONDecoder()
    
    func getAllSchools(offset: Int, completion: @escaping (Scools?, Error?) -> Void) {
        let url = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json?$limit=30&$offset=\(offset)&$order=school_name"
        if let URL = URL(string: url) {
            performRequest(URL: URL, completion: completion)
        }
    }
    
    func getAdditionalInformation(dbn: String, completion: @escaping ([SchoolAdditionalInformationNetworkModel]?, Error?) -> Void) {
        let url = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json?dbn=\(dbn)"
        if let URL = URL(string: url) {
            performRequest(URL: URL, completion: completion)
        }
    }
    
    
    
    private func performRequest<T: Decodable>(URL: URL, completion: @escaping (T?, Error?) -> Void) {
        let sharedSession = URLSession.shared
        let dataTask = sharedSession.dataTask(with: URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print("Error to load: \(String(describing: error?.localizedDescription))")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            if let dataResponse = data {
                
                do {
                    
                    let newdata = try self.decoder.decode(T.self, from: dataResponse)
                    print("Data: \(newdata), error: \(String(describing: error))")
                    
                    DispatchQueue.main.async {
                        completion(newdata, nil)
                    }
                   
                    return
                    
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                  
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                  
                }
            }
        })
        dataTask.resume()
    }
    
}

