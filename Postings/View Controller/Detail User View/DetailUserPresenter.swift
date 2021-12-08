//
//  DetailUserPresenter.swift
//  Postings
//
//  Created by Elabram MacbookPro on 07/12/21.
//

import Foundation

class DetailUserPresenter: ViewToPresenterDetailUserProtocol{
    
    var view: PresenterToViewDetailUserProtocol?
    var interactor: PresenterToInteractorDetailUserProtocol?
    var router: PresenterToRouterDetailUserProtocol?
    
    var listAlbum: [Album]?
    var user: User?
    var userId: Int?
    
    init(user: User, userId: Int) {
        self.userId = userId
        self.user = user
    }
    
    func viewDidLoad() {
        requestAlbumIndex(loadMore: false)
    }
    
    func refreshData(loadMore: Bool) {
        requestAlbumIndex(loadMore: false)
    }
    
    func selectRowAt(index: Int) {
        if let album = listAlbum?[index]{
            router?.pushTo(view: .detail(album: album))
        }
    }
    
    func requestAlbumIndex(loadMore: Bool) {
        interactor?.apiAlbumIndex(parameters: [:])
    }
    
    
}

extension DetailUserPresenter: InteractorToPresenterDetailUserProtocol{
    
    func successGetAlbumIndex(response: [Album]) {
        listAlbum = response
        
        view?.successGetAlbumIndex()
    }
    
    func failureGetAlbumIndex(message: String) {
        view?.failureGetAlbumIndex(message: message)
    }
    
    
}
