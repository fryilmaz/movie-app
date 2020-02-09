//
//  BaseService.swift
//  MovieApp
//
//  Created by Faruk on 7.02.2020.
//  Copyright © 2020 Faruk. All rights reserved.
//

import Foundation

enum ServiceError:String, Error{
    case unknown = "An unknown error occured!"
    case badRequest = "Bad Request!"
    case notFound = "The url you have typed not found"
    case unauthorized = "UnAuthorized Access!!"
    case internalServerError = "Internal Server Error occured!!"
    case invalidData = "Invalid Data!"
}

class BaseService {
    
    func fetch<T:Decodable>(url:URL,completion:@escaping(Result<T,ServiceError>) -> ()) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.unknown))
                return
            }
            if httpResponse.statusCode == 400 {
                completion(.failure(.badRequest))
                return
            }
            else if httpResponse.statusCode == 404 {
                completion(.failure(.notFound))
                return
            }
            else if httpResponse.statusCode == 401 {
               completion(.failure(.unauthorized))
               return
            }
            else if httpResponse.statusCode == 500 {
                completion(.failure(.internalServerError))
               return
            }
            else if httpResponse.statusCode == 200 {
                if let data = data{
                    let decoder = JSONDecoder()
                    do {
                        let json = try decoder.decode(T.self, from: data)
                        completion(.success(json))
                    } catch {
                        print(error.localizedDescription)
                        completion(.failure(.invalidData))
                    }
                }
                else{
                    completion(.failure(.invalidData))
                }
               return
            }
        }.resume()
    }    
}
