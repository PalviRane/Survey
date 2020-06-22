//
//  WebserviceHandler.swift
//  Survey
//
//  Created by Palvi on 22/06/20.
//  Copyright © 2020 Palvi. All rights reserved.
//

import Foundation
import Alamofire

class WebserviceHandler
{
    
    func createHeader() -> HTTPHeaders
    {
        var headers = HTTPHeaders.init()
        if let token = TokenKeychainWrapper().getToken()
        {
            headers["Authorization"] = "34054f8e54e09016c2df8fbb6ee44c944079dd965d9c4ec24c1aae35f97d09ee"//token
        }
        return headers
    }
    
    // MARK: POST and Other Requests
    func makeAPIRequest(url: String, methodType: HTTPMethod, parameter: [String: Any]?, completion: @escaping (Bool, DataResponse<Any>) -> ())
    {
        makeAPICall(request: createRequest(url: url, methodType: methodType, parameter: parameter), completion: completion)
    }
    
    // MARK : Get Request
    func get(url: String, parameter: [String: AnyObject]?, completion: @escaping (Bool, DataResponse<Any>) -> ()){
        
        let urlString = url+"?"+createGetParameterString(params: parameter)
        let request = Alamofire.request(urlString, headers: createHeader())
        
        makeAPICall(request: request, completion: completion)
    }
    
    // MARK: Create GET URL
    func createGetParameterString(params: [String: AnyObject]?) -> String {
        var paramString = ""
        if let params = params {
            
            for (key, var value) in params
            {
                if value is Int
                {
                    let valueInt: Int = value as! Int
                    let valueString = String(valueInt)
                    value = valueString as AnyObject
                }
                
                let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                paramString += "\(escapedKey)=\(escapedValue)&"
                
            }
        }
        return paramString
    }
    
    // MARK: POST Request
    func createRequest(url: String, methodType: HTTPMethod, parameter: [String: Any]?) -> DataRequest{
        
        return Alamofire.request(url, method: methodType, parameters: parameter, encoding: JSONEncoding.default, headers: createHeader())
    }
    
    
    // MARK: Get Response
    func makeAPICall(request: DataRequest, completion: @escaping (Bool, DataResponse<Any>) -> ())
    {
        request.validate().responseJSON { responseData in
            
                guard responseData.result.error == nil else
                {
                    print(responseData.result.error!)
                    return completion(false, responseData)
                }
                
                return completion(responseData.result.isSuccess, responseData)
        }
    }
}
