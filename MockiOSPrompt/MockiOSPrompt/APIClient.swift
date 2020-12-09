//
//  APIClient.swift
//  MockiOSPrompt
//
//  Created by Kelby Mittan on 12/3/20.
//

import Foundation
import Combine

struct APIClient {
    
    //    func fetchPodcasts(_ search: String, completionHandler: @escaping (Result<[Podcast],Error>) -> ()) {
    //
    //        var endpoint = "https://itunes.apple.com/search?media=podcast&limit=200&term=\(search)"
    //        endpoint = endpoint.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    //
    //        guard let url = URL(string: endpoint) else {
    //            return
    //        }
    //
    ////        let request = URLRequest(url: url)
    //        URLSession.shared.dataTask(with: url) { (data, response, error) in
    //
    //            if let error = error {
    //                completionHandler(.failure(error))
    //            }
    //
    //            if let data = data {
    //                do {
    //                    let results = try JSONDecoder().decode(SearchResults.self, from: data).results
    //                    completionHandler(.success(results))
    //                } catch {
    //                    completionHandler(.failure(error))
    //                }
    //            }
    //        }.resume()
    //    }
    
    //    func fetchPodcasts(search: String, completion: @escaping (Result<[Podcast],Error>) -> ()) {
    //
    //        let endpointURLString = "https://itunes.apple.com/search?media=podcast&limit=200&term=\(search)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    //        guard let urlString = endpointURLString, let url = URL(string: urlString) else {
    //            return
    //        }
    //        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
    //            if let error = error {
    //                return completion(.failure(error))
    //            }
    //            if let data = data {
    //                do {
    //                    let results = try JSONDecoder().decode(SearchResults.self, from: data).results
    //                    completion(.success(results))
    //                } catch {
    //                    completion(.failure(error))
    //                }
    //            }
    //        }
    //        dataTask.resume()
    //    }
    
    func fetchPodcasts(search: String, completion: @escaping (Result<[Podcast],Error>) -> ()) {
        
        let endpointURLString = "https://itunes.apple.com/search?media=podcast&limit=200&term=\(search)"
        guard let url = URL(string: endpointURLString) else {
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(SearchResults.self, from: data).results
                    completion(.success(results))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    public func getPodcasts(_ search: String, _ completion: @escaping (Result<[Podcast],Error>) -> ()) {
        
        let endpoint = ""
        
        guard let url = URL(string: endpoint) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(SearchResults.self, from: data).results
                    completion(.success(results))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    public func searchForPodcasts(for query: String) -> AnyPublisher<[Podcast],Error> {
        
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "paris"
        let endpoint = "https://itunes.apple.com/search?media=podcast&limit=200&term=\(query)"
        
//        guard let url = URL(string: endpoint) else {
//             fatalError()
//        }
        
        let url = URL(string: endpoint)!
                
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: SearchResults.self, decoder: JSONDecoder())
            .map { $0.results }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getDaPCasts(search: String, completion: @escaping (Result<[Podcast],Error>) -> ()) {
        
        let endpoint = ""
        
        guard let url = URL(string: endpoint) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(SearchResults.self, from: data).results
                    completion(.success(results))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
}
