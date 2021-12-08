//
//  Comment.swift
//  Postings
//
//  Created by Elabram MacbookPro on 08/12/21.
//

import Foundation

struct Comment: Codable{
    
    let postId: Int?
    let id: Int?
    let name: String?
    let email: String?
    let body: String?
    
    enum CodingKeys: String, CodingKey{
        case postId
        case id
        case name
        case email
        case body
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        postId = try values.decodeIfPresent(Int.self, forKey: .postId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        body = try values.decodeIfPresent(String.self, forKey: .body)
    }
}
