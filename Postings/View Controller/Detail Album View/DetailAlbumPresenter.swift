//
//  DetailAlbumPresenter.swift
//  Postings
//
//  Created by Elabram MacbookPro on 08/12/21.
//

import Foundation

class DetailAlbumPresenter: ViewToPresenterDetailAlbumProtocol{
    
    private var albumId: Int?
    
    var view: PresenterToViewDetailAlbumProtocol?
    var interactor: PresenterToInteractorDetailAlbumProtocol?
    var router: PresenterToRouterDetailAlbumProtocol?
    
    var listPhoto: [Photo]?
    
    var album: Album?
    
    init(album: Album, albumId: Int) {
        self.albumId = albumId
        self.album = album
    }
    
    func viewDidLoad() {
        requestPhotoIndex(loadMore: false)
    }
    
    func refreshData(loadMore: Bool) {
        requestPhotoIndex(loadMore: false)
    }
    
    func selectRowAt(index: Int) {
        interactor?.storeAndShareLabel(withURLString: listPhoto?[index].thumbnailUrl ?? "")
    }
    
    func requestPhotoIndex(loadMore: Bool) {
        interactor?.apiPhotoIndex(parameters: [:])
    }
    
    
}

extension DetailAlbumPresenter: InteractorToPresenterDetailAlbumProtocol{
    
    func share(url: URL) {
        view?.share(url: url)
    }
    
    func successGetPhotoIndex(response: [Photo]) {
        listPhoto = response
        
        view?.successGetPhotoIndex()
    }
    
    func failureGetPhotoIndex(message: String) {
        view?.failureGetPhotoIndex(message: message)
    }
    
    
}
