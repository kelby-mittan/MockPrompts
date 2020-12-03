//
//  APIClient.swift
//  CountryMockPrompt
//
//  Created by Kelby Mittan on 12/3/20.
//

import Foundation

struct APIClient {
    
    func fetchCovidData(completion: @escaping (Result<[Summary],Error>) -> ()) {
        
        let endpointURLString = "https://api.covid19api.com/summary"
        
        guard let url = URL(string: endpointURLString) else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                return completion(.failure(error))
            }
            
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(SummaryWrapper.self, from: data).countries
                    completion(.success(results))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        dataTask.resume()
    }
}
