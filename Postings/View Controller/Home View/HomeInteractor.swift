//
//  HomeInteractor.swift
//  Postings
//
//  Created by Elabram MacbookPro on 05/12/21.
//

import Foundation
import Alamofire

class HomeInteractor: PresenterToInteractorHomeProtocol{
    
    var presenter: InteractorToPresenterHomeProtocol?
    
    let postsURL = "https://jsonplaceholder.typicode.com/posts"
    let usersURL = "https://jsonplaceholder.typicode.com/users"
    
    let noDataMessage = "404: Sorry we're unable to find data"
    
    init(presenter: InteractorToPresenterHomeProtocol) {
        self.presenter = presenter
    }
    
    func apiPostIndex(loadMore: Bool, parameters: [String : Any]) {
        AF.request(postsURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result{
                    
                case .success(let value):
                    print(value)
                    
                    do {
                        let decoder = JSONDecoder()
                        
                        if let data = response.data{
                            
                            let response = try decoder.decode([Post].self, from: data)
                            
                            self.presenter?.successHomeIndex(loadMore: loadMore, response: response)
                            
                            
                        } else {
                            
                            self.presenter?.failureHomeIndex(message: self.noDataMessage)
                            
                        }
                        
                    } catch let err {
                        
                        self.presenter?.failureHomeIndex(message: err.localizedDescription)
                        
                    }

                case .failure(let err):
                    self.presenter?.failureHomeIndex(message: err.localizedDescription)
                }
            }
    }
    
    func apiUserIndex(parameters: [String : Any]) {
        AF.request(usersURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result{
                    
                case .success(let value):
                    print(value)
                    
                    do {
                        let decoder = JSONDecoder()
                        
                        if let data = response.data{
                            
                            let response = try decoder.decode([User].self, from: data)
                            
                            self.presenter?.successUserIndex(response: response)
                            
                            self.apiPostIndex(loadMore: false, parameters: [:])
                            
                            
                        } else {
                            
                            self.presenter?.failureUserIndex(message: self.noDataMessage)
                            
                        }
                        
                    } catch let err {
                        
                        self.presenter?.failureUserIndex(message: err.localizedDescription)
                        
                    }

                case .failure(let err):
                    
                    self.presenter?.failureUserIndex(message: err.localizedDescription)
                    
                }
            }
    }
    
    
}
