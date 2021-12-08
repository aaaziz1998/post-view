//
//  Address.swift
//  Postings
//
//  Created by Elabram MacbookPro on 07/12/21.
//

import Foundation

struct Address: Codable{
    
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    
    enum CodingKeys: String, CodingKey{
        case street
        case suite
        case city
        case zipcode
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        street = try values.decodeIfPresent(String.self, forKey: .street)
        suite = try values.decodeIfPresent(String.self, forKey: .suite)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        zipcode = try values.decodeIfPresent(String.self, forKey: .zipcode)
    }
}
