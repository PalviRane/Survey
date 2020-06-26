//
//  AuthenticationTokenViewModel.swift
//  Survey
//
//  Created by Aakash Kumbhar on 22/06/20.
//  Copyright © 2020 Palvi. All rights reserved.
//

import Foundation

class AuthenticationTokenViewModel
{
    func getAuthenticationToken(onSuccess: @escaping () -> Void, onFailure: @escaping () -> Void)
    {        
        let requestDictionary = [ "grant_type":grantTypeString, "username":userNameString, "password":passwordString ] as Dictionary<String, AnyObject>
        
        let urlString = WebServiceUrls().baseURL + WebServiceUrls().getAuthToken
        
        WebserviceHandler().makeAPIRequest(url: urlString, methodType: .post, parameter: requestDictionary) { (success, responseData) in
            DispatchQueue.main.async(execute:
                {
                    if success
                    {
                        do
                        {
                            guard let response = responseData.data else {return}
                            
                            let authTokenModel: AuthenticationTokenModel? = try JSONDecoder().decode(AuthenticationTokenModel.self, from: response)
                            
                            if let token = authTokenModel, let access_token = token.accessToken
                            {
                                let setTokenSuccess = TokenKeychainWrapper().set(token: access_token)
                                if setTokenSuccess
                                {
                                    onSuccess()
                                }
                                else
                                {
                                    onFailure()
                                }
                            }
                        }
                        catch let jsonError
                        {
                            print(jsonError)
                            onFailure()
                        }
                    }
                    else
                    {
                        onFailure()
                    }
            })
        }
    }
    
}

