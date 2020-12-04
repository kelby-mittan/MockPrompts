//
//  APIClient.swift
//  MockiOSPrompt
//
//  Created by Kelby Mittan on 12/3/20.
//

import Foundation

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
}
