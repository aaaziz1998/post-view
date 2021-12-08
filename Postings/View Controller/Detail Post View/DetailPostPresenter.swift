//
//  DetailPostPresenter.swift
//  Postings
//
//  Created by Elabram MacbookPro on 08/12/21.
//

import Foundation

class DetailPostPresenter: ViewToPresenterDetailPostProtocol{
    
    var view: PresenterToViewDetailPostProtocol?
    var interactor: PresenterToInteractorDetailPostProtocol?
    var router: PresenterToRouterDetailPostProtocol?
    
    var listComment: [Comment]?
    var listUser: [User]?
    var post: Post?
    var postUser: User?
    
    init(listUser: [User], post: Post, postUser: User) {
        self.listUser = listUser
        self.post = post
        self.postUser = postUser
    }
    
    func viewDidLoad() {
        requestCommentIndex(loadMore: false)
    }
    
    func refreshData(loadMore: Bool) {
        requestCommentIndex(loadMore: false)
    }
    
    func selectRowAt(index: Int) {
        if let user = searchUser(email: listComment?[index].email ?? ""){
            router?.pushTo(view: .detailUser(user: user))
        }
    }
    
    func selectPostUser() {
        if let user = postUser{
            router?.pushTo(view: .detailUser(user: user))
        }
    }
    
    func searchUser(email: String) -> User? {
        return listUser?.first(where: {return $0.email?.lowercased() == email.lowercased()})
    }
    
    func requestCommentIndex(loadMore: Bool) {
        interactor?.apiCommentIndex(parameters: [:])
    }
    
    
}

extension DetailPostPresenter: InteractorToPresenterDetailPostProtocol{
    
    func successGetCommentIndex(response: [Comment]) {
        listComment = response
        
        view?.successGetCommentIndex()
    }
    
    func failureGetCommentIndex(message: String) {
        view?.failureGetCommentIndex(message: message)
    }
    
    
}
