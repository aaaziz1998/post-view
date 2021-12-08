//
//  DetailUserInteractor.swift
//  Postings
//
//  Created by Elabram MacbookPro on 07/12/21.
//

import Foundation
import Alamofire

class DetailUserInteractor: PresenterToInteractorDetailUserProtocol{
    
    var presenter: InteractorToPresenterDetailUserProtocol?
    
    var userId: Int = .zero
    let albumURL = "https://jsonplaceholder.typicode.com/albums?userId="
    
    let noDataMessage = "404: Sorry we're unable to find data"
    
    init(presenter: InteractorToPresenterDetailUserProtocol, userId: Int) {
        self.presenter = presenter
        self.userId = userId
    }
    
    func apiAlbumIndex(parameters: [String : Any]) {
        let url = albumURL+"\(userId)"
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result{
                    
                case .success(let value):
                    print(value)
                    
                    do {
                        let decoder = JSONDecoder()
                        
                        if let data = response.data{
                            
                            let response = try decoder.decode([Album].self, from: data)
                            
                            self.presenter?.successGetAlbumIndex(response: response)
//                                .successHomeIndex(loadMore: loadMore, response: response)
                            
                            
                        } else {
                            
                            self.presenter?.failureGetAlbumIndex(message: self.noDataMessage)
//                                .failureHomeIndex(message: self.noDataMessage)
                            
                        }
                        
                    } catch let err {
                        
                        self.presenter?.failureGetAlbumIndex(message: err.localizedDescription)
//                            .failureHomeIndex(message: err.localizedDescription)
                        
                    }

                case .failure(let err):
                    self.presenter?.failureGetAlbumIndex(message: err.localizedDescription)
//                        .failureHomeIndex(message: err.localizedDescription)
                }
            }
    }
    
    
}
