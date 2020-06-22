//
//  NetworkManager.swift
//  Survey
//
//  Created by Aakash Kumbhar on 22/06/20.
//  Copyright © 2020 Palvi. All rights reserved.
//

import Foundation
import Alamofire

import Alamofire

class NetworkManager
{
    class var isConnectedToInternet:Bool
    {
        return NetworkReachabilityManager()!.isReachable
    }
    
}
