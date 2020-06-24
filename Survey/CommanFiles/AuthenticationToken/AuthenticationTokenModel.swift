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
    let access_token:String?
    let token_type: String?
    let expires_in: Int?
    let created_at: UInt64?
}
