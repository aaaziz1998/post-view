//
//  HomePresenter.swift
//  Postings
//
//  Created by Elabram MacbookPro on 05/12/21.
//

import Foundation

class HomePresenter: ViewToPresenterHomeProtocol{
    
    var view: PresenterToViewHomeProtocol?
    var interactor: PresenterToInteractorHomeProtocol?
    var router: PresenterToRouterHomeProtocol?
    
    var listPosts: [Post]?
    var listUsers: [User]?
    
    func viewDidLoad() {
        interactor?.apiUserIndex(parameters: [:])
    }
    
    func refreshData(loadMore: Bool) {
        interactor?.apiPostIndex(loadMore: loadMore, parameters: [:])
    }
    
    func searchUser(id: Int) -> User?{
        return listUsers?.first(where: {return $0.id == id})
    }
    
    func selectRowAt(index: Int) {
        if let user = searchUser(id: listPosts?[index].userId ?? .zero),
           let post = listPosts?[index]{
            router?.pushTo(view: .detailPost(post: post, postBy: user, listUser: listUsers ?? [User]()))
        }
    }
    
    func selectUserRowAt(index: Int) {
        if let user = searchUser(id: listPosts?[index].userId ?? .zero){
            router?.pushTo(view: .detailUser(user: user))
        }
    }
    
    func requestPostIndex(loadMore: Bool) {
        interactor?.apiPostIndex(loadMore: loadMore, parameters: [:])
    }
    
}

extension HomePresenter: InteractorToPresenterHomeProtocol{
    
    func successUserIndex(response: [User]) {
        listUsers = response
        
        view?.successGetUserIndex()
    }
    
    func failureUserIndex(message: String) {
        view?.failureGetUserIndex(message: message)
    }
    
    
    func successHomeIndex(loadMore: Bool, response: [Post]) {
        listPosts = response
        
        view?.successGetHomeIndex()
    }
    
    func failureHomeIndex(message: String) {
        view?.failureGetHomeIndex(message: message)
    }
    
    
}
