//
//  Webservice.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/3/22.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case decodingError
}

class Webservice {
    
    // Get function that gets anything that is a decodable, in this case it's the URL -- spoonacular API
    // What is parse?
    // The type (T) is Decodable
    func get<T: Decodable>(url: URL, parse: (Data) -> T?) async throws -> T {
        
        // Performs the request. Returns data and the response.
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Raises an error if data does not exist
        if (response as? HTTPURLResponse)?.statusCode != 200 {
            throw NetworkError.badRequest
        }
        
        // Gets the result by calling the parse function with the data. If no result, then throw decoding error.
        guard let result = parse(data) else {
            throw NetworkError.decodingError
        }
        
        return result
    }
    
}
