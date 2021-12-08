//
//  DetailAlbumRouter.swift
//  Postings
//
//  Created by Elabram MacbookPro on 08/12/21.
//

import Foundation
import UIKit

class DetailAlbumRouter: PresenterToRouterDetailAlbumProtocol{
    
    weak var navigationController: UINavigationController?
    
    static func createModule(using navigationController: UINavigationController?, albumId: Int, album: Album) -> UIViewController {
        let presenter: ViewToPresenterDetailAlbumProtocol & InteractorToPresenterDetailAlbumProtocol = DetailAlbumPresenter(album: album, albumId: albumId)
//        DetailAlbumPresenter(user: user, userId: user.id ?? .zero)
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: "detailAlbumViewController") as? DetailAlbumViewController else {return UIViewController()}
        
        let router = DetailAlbumRouter()
        router.navigationController = navigationController
        
        viewController.presenter = presenter
        viewController.presenter?.router = router
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = DetailAlbumInteractor(presenter: presenter, albumId: albumId)
        
        return viewController
    }
    
    func pushTo(view: DetailAlbumRouting) {
        
    }
    
    
}
