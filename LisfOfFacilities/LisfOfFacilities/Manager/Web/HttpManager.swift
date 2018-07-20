//
//  HttpManager.swift
//  LisfOfFacilities
//
//  Created by Avinash on 18/07/18.
//  Copyright © 2018 Demansol. All rights reserved.
//

import Foundation

struct WebServiceConstants {
    static let facitlitiesURL = "https://my-json-server.typicode.com/iranjith4/ad-assignment/db"
}

enum HTTPMethodType: String {
    case POST = "POST"
    case GET = "GET"
}

class HttpManager: NSObject {
    
    static let sharedService = HttpManager()
    
    func requestAPI(url: String, parameter: [String: AnyObject]?, httpMethodType: HTTPMethodType, completion: @escaping (_ data: [String:Any]?, _ error: Error?) -> ()) {
        
        let escapedAddress = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        var request = URLRequest(url: URL(string: escapedAddress!)!)
        request.httpMethod = httpMethodType.rawValue
        
        if parameter != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameter as Any, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
                return
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            // check for http errors
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("Error in fetching response")
            }
            
            //create json object from data
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    completion(json as [String : AnyObject], nil)
                }
            } catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
        task.resume()
    }
    
}
