//
//  NetworkManager.swift
//  ViperDemo
//
//  Created by Adeel Tahir on 12/17/22.
//

import Foundation

enum RequestType: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
}

struct NetworkResponseData {
    var statusCode: Int
    var data: Data?
    var error: HTTPError?
}

typealias Parameters = Dictionary<String,Any>

class NetworkService {
    private let session = URLSession.shared
    static let shared = NetworkService()
    
    func loadNetworkData(requestType: RequestType, fromUrl urlStr: String, parameters: Parameters, completion: @escaping (NetworkResponseData) -> ()) {
        var responseData = NetworkResponseData(statusCode: 0, data: nil, error: nil)
        
        if !NetworkManagerUtility.isConnectedToNetwork() {
            responseData.error = .noConnectionError("No Internet!")
            completion(responseData)
        } else {
            if let urlString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) {
                var request = URLRequest(url: url)
                request.httpMethod = requestType.rawValue
                
                if requestType.rawValue == RequestType.post.rawValue || requestType.rawValue == RequestType.put.rawValue {
                    do {
                        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }else{
                    request.cachePolicy =  NetworkManagerUtility.isConnectedToNetwork() ? .useProtocolCachePolicy : .returnCacheDataDontLoad
                }
                
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                request.addValue("Bearer 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", forHTTPHeaderField: "Authorization")
                
                let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                    var statusCode : Int = 0

                    if let httpResponse = response as? HTTPURLResponse {
                        statusCode = httpResponse.statusCode
                        print("statusCode: \(httpResponse.statusCode)")
                    }
                    
                    if let error = error{
                        responseData.error = .transportError(error)
                    }else{
                        responseData.statusCode = statusCode
                        responseData.data = data
                    }
                    completion(responseData)
                })
                
                task.resume()
            }
        }
    }
}
