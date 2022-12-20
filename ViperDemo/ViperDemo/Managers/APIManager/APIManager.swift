//  ViperDemo
//
//  Created by Adeel Tahir on 12/17/22.
//

import Foundation

class APIGeneric<response: Codable> {
    
    static func fetchRequest(apiURL:String, completion: @escaping (Resource<response>) -> Void) {
        print(apiURL)
        
        var resource = Resource<response>(data: nil, error: nil, state: .loading)
        completion(resource)
        
        NetworkService.shared.loadNetworkData(requestType: .get, fromUrl: apiURL, parameters: [:]) { networkResponse in
            if let err = networkResponse.error {
                resource.error = err
            } else {
                do {
                    if let data = networkResponse.data {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                        print(jsonResponse)
                        
                        if (jsonResponse as? NSArray)?.count == 0 {
                            resource.error = .serverSideError("No Data Found.")
                        }
                        else {
                            if networkResponse.statusCode == 200 {
                                let responseModel = try JSONDecoder().decode(response.self, from: data)
                                resource.data = responseModel
                            } else {
                                let responseModel = try JSONDecoder().decode(NotSuccessModel.self, from: data)
                                resource.error = .serverSideError(responseModel.message ?? "")
                            }
                        }
                    }
                    else {
                        resource.state = .failure
                    }
                } catch let error {
                    resource.error = .serverSideError(error.localizedDescription)
                }
            }
            
            completion(resource)
        }
    }
}

class PostAPIGeneric<request: Codable,response: Codable> {

    static func postRequest(apiURL:String, requestType: RequestType = .post ,requestModel:request, completion: @escaping (Resource<response>) -> Void) {

        print(apiURL)
        
        var resource = Resource<response>(data: nil, error: nil, state: .loading)
        completion(resource)
        
        guard let parameters = requestModel.dictionary else {
            resource.state = .failure
            completion(resource)
            return
        }
        
        NetworkService.shared.loadNetworkData(requestType: .get, fromUrl: apiURL, parameters: parameters) { networkResponse in
            if let err = networkResponse.error {
                resource.error = err
            } else {
                do {
                    if let data = networkResponse.data {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                        print(jsonResponse)
                        
                        if (jsonResponse as? NSArray)?.count == 0 {
                            resource.error = .serverSideError("No Data Found.")
                        }
                        else {
                            if networkResponse.statusCode == 200 {
                                let responseModel = try JSONDecoder().decode(response.self, from: data)
                                resource.data = responseModel
                            } else {
                                let responseModel = try JSONDecoder().decode(NotSuccessModel.self, from: data)
                                resource.error = .serverSideError(responseModel.message ?? "")
                            }
                        }
                    }
                    else {
                        resource.state = .failure
                    }
                } catch let error {
                    resource.error = .serverSideError(error.localizedDescription)
                }
            }
            
            completion(resource)
        }
    }
}
