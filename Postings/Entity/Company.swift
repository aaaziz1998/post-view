//
//  Company.swift
//  Postings
//
//  Created by Elabram MacbookPro on 07/12/21.
//

import Foundation

struct Company: Codable{
    
    let name: String?
    let catchPhrase: String?
    let bs: String?
    
    enum CodingKeys: String, CodingKey{
        case name
        case catchPhrase
        case bs
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        catchPhrase = try values.decodeIfPresent(String.self, forKey: .catchPhrase)
        bs = try values.decodeIfPresent(String.self, forKey: .bs)
    }
}
