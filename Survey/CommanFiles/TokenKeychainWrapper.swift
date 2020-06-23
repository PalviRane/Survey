//
//  TokenKeychainWrapper.swift
//  Survey
//
//  Created by Aakash Kumbhar on 22/06/20.
//  Copyright © 2020 Palvi. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class TokenKeychainWrapper
{
    static let sharedInstance: TokenKeychainWrapper = {return TokenKeychainWrapper()}()
    
    func set(userName: String) -> Bool
    {
        KeychainWrapper.standard.set(userName, forKey: userNameKey)
    }
    
    func set(password: String) -> Bool
    {
        KeychainWrapper.standard.set(password, forKey: passwordKey)
    }
    
    func set(token: String) -> Bool
    {
        KeychainWrapper.standard.set(token, forKey: tokenKey)
    }
}

extension TokenKeychainWrapper
{
    func getUserName() -> String?
    {
        return KeychainWrapper.standard.string(forKey: userNameKey) ?? ""

    }
    
    func getPassword() -> String?
    {
        return KeychainWrapper.standard.string(forKey: passwordKey) ?? ""
    }
    
    func getToken() -> String?
    {
        return KeychainWrapper.standard.string(forKey: tokenKey) ?? ""
    }
}
