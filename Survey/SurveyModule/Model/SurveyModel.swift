//
//  SurveyModel.swift
//  Survey
//
//  Created by Aakash Kumbhar on 24/06/20.
//  Copyright © 2020 Palvi. All rights reserved.
//

import Foundation

struct SurveyModel: Codable
{
    let id:String?
    let title: String?
    let description: String?
    let coverImageUrl: String?
    
    private enum CodingKeys : String, CodingKey
    {
        case id = "id"
        case title = "title"
        case description = "description"
        case coverImageUrl = "cover_image_url"
    }
}
