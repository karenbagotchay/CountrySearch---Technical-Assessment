//
//  APIClient.swift
//  CountrySearch
//
//  Created by Karen Bagotchay on 4/29/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case statusCodeError(Int)
    case urlError(URLError)
    case unknownError(Error)
    case requestFailed
    case decodingError(DecodingError)
}

class APIClient {
    
    static let shared = APIClient()
    
    private init() {}
    
    private let baseURL = "https://restcountries.com"
    
    enum HTTPMethod: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
    
    private func request<T: Decodable>(
        url: URL,
        method: HTTPMethod,
        body: Data? = nil
    ) async -> Result<T, NetworkError> {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = body
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(.requestFailed)
            }
            
            guard (200..<300).contains(httpResponse.statusCode) else {
                return .failure(.statusCodeError(httpResponse.statusCode))
            }
            
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedResponse)
        } catch let error as URLError {
            return .failure(.urlError(error))
        } catch let error as DecodingError {
            return .failure(.decodingError(error))
        } catch {
            return .failure(.unknownError(error))
        }
    }
    
    private func get<T: Decodable>(endpoint: String) async -> Result<T, NetworkError> {
        let urlString = baseURL + endpoint
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        return await request(url: url, method: .GET)
    }
    
    
    func getAllCountries() async -> Result<[Country], NetworkError> {
        return await get(endpoint: "/v3.1/all")
    }
}
