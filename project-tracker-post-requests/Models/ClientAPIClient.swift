//
//  ClientAPIClient.swift
//  project-tracker-post-requests
//
//  Created by Levi Davis on 9/12/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct ClientAPIClient {
    static let manager = ClientAPIClient()
    
    func getClients(completionHandler: @escaping (Result<[Client],AppError>) -> Void ) {
        NetworkHelper.manager.performDataTask(url: airTableClientURL, httpMethod: .get) { (result) in
            
            switch result {
            case let .failure(error):
                completionHandler(.failure(error))
                return
            case let .success(data):
                do {
                    let clients = try Client.getClients(from: data)
                    completionHandler(.success(clients))
                    
                }
                catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
    
    func postClient(client: Client, completionHandler: @escaping (Result<Data,AppError>) -> () ) {
        let clientWrapper = ClientWrapper(client: client)
        guard let encodedClientWrapper = try? JSONEncoder().encode(clientWrapper) else {fatalError()}
        NetworkHelper.manager.performDataTask(url: airTableClientURL, httpMethod: .post, data: encodedClientWrapper) { (result) in
            switch result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
   
    
    private var airTableClientURL: URL {
        guard let url = URL(string: "https://api.airtable.com/v0/\(Secrets.APISubPath)/Clients?&view=All%20clients&api_key=\(Secrets.APIKey)") else {fatalError("Error: Invalid URL")}
        return url
    }
    
    private init() {}
}
