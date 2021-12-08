//
//  Extension.swift
//  Postings
//
//  Created by Elabram MacbookPro on 08/12/21.
//

import Foundation

extension URL {
    
    var typeIdentifier: String? {
        return (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }
    
    var localizedName: String? {
        return (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName
    }
    
}
