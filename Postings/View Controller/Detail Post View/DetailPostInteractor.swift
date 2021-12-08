//
//  DetailPostInteractor.swift
//  Postings
//
//  Created by Elabram MacbookPro on 08/12/21.
//

import Foundation
import Alamofire

class DetailPostInteractor: PresenterToInteractorDetailPostProtocol{
    
    var presenter: InteractorToPresenterDetailPostProtocol?
    
    var postId: Int = .zero
    
    let commentsURL = "https://jsonplaceholder.typicode.com/comments?postId="
    
    let noDataMessage = "404: Sorry we're unable to find data"
    
    init(presenter: InteractorToPresenterDetailPostProtocol?, postId: Int) {
        self.presenter = presenter
        self.postId = postId
    }
    
    func apiCommentIndex(parameters: [String : Any]) {
        let url = commentsURL+"\(postId)"
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result{
                    
                case .success(let value):
                    print(value)
                    
                    do {
                        let decoder = JSONDecoder()
                        
                        if let data = response.data{
                            
                            let response = try decoder.decode([Comment].self, from: data)
                            
                            self.presenter?.successGetCommentIndex(response: response)

                        } else {
                            
                            self.presenter?.failureGetCommentIndex(message: self.noDataMessage)
//                                .failureGetPhotoIndex(message: self.noDataMessage)
                            
                        }
                        
                    } catch let err {
                        
                        self.presenter?.failureGetCommentIndex(message: err.localizedDescription)
                        
                    }

                case .failure(let err):
                    self.presenter?.failureGetCommentIndex(message: err.localizedDescription)
                }
            }
    }
    
    
}
