//
//  AuthenticationTokenModel.swift
//  Survey
//
//  Created by Aakash Kumbhar on 24/06/20.
//  Copyright © 2020 Palvi. All rights reserved.
//

import Foundation

struct AuthenticationTokenModel: Codable
{
    let accessToken:String?
    let tokenType: String?
    let expiresIn: Int?
    let createdAt: UInt64?
    
    private enum CodingKeys : String, CodingKey
    {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case createdAt = "created_at"
    }
}
