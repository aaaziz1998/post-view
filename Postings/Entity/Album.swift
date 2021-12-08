//
//  Album.swift
//  Postings
//
//  Created by Elabram MacbookPro on 07/12/21.
//

import Foundation

struct Album: Codable{
    
    let userId: Int?
    let id: Int?
    let title: String?
    
    enum CodingKeys: String, CodingKey{
        case userId
        case id
        case title
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
}
