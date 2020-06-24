//
//  AuthenticationTokenViewModel.swift
//  Survey
//
//  Created by Aakash Kumbhar on 22/06/20.
//  Copyright © 2020 Palvi. All rights reserved.
//

import Foundation

protocol AuthenticationTokenDelegate
{
    func authenticationTokenGenerationResponse(isSuccess: Bool)
}

extension AuthenticationTokenDelegate
{
    func authenticationTokenGenerationResponse(isSuccess: Bool){}
}

class AuthenticationTokenViewModel
{
    //MARK: Properties
    var delegate: AuthenticationTokenDelegate?
    
    
    func getAuthenticationToken()
    {
        if !NetworkManager.isConnectedToInternet
        {
            //Show internet connectivity issue error
            return
        }
        
        let requestDictionary = [ "grant_type":grantTypeString, "username":"carlos@nimbl3.com", "password":"antikera" ] as Dictionary<String, AnyObject>
        
        let urlString = WebServiceUrls().baseURL + WebServiceUrls().getAuthToken
        
        WebserviceHandler().makeAPIRequest(url: urlString, methodType: .post, parameter: requestDictionary) { (flag, responseData) in
            DispatchQueue.main.async(execute:
                {
                    print(responseData)
                    print(ERR_SUCCESS)
            })
        }
    }
    
    func mapToAuthenticationTokenModel(response: Data?, success:Bool, urlResponse: HTTPURLResponse )
    {
        if success
        {
            do
            {
                guard let response = response else {return}
                let authTokenModel: AuthenticationTokenModel? = try JSONDecoder().decode(AuthenticationTokenModel.self, from: response)
                
                if let token = authTokenModel, let access_token = token.access_token
                {
                    let setTokenSuccess = TokenKeychainWrapper().set(token: access_token)
                    delegate?.authenticationTokenGenerationResponse(isSuccess: setTokenSuccess)
                }
            }
            catch let jsonError
            {
                print(jsonError)
                delegate?.authenticationTokenGenerationResponse(isSuccess: false)
            }
        }
        else
        {
            delegate?.authenticationTokenGenerationResponse(isSuccess: false)
        }
    }
}

