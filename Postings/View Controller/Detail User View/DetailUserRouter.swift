//
//  DetailUserRouter.swift
//  Postings
//
//  Created by Elabram MacbookPro on 07/12/21.
//

import Foundation
import UIKit

class DetailUserRouter: PresenterToRouterDetailUserProtocol{
    
    weak var navigationController: UINavigationController?
    
    static func createModule(using navigationController: UINavigationController?, userId: Int, user: User) -> UIViewController {
        let presenter: ViewToPresenterDetailUserProtocol & InteractorToPresenterDetailUserProtocol = DetailUserPresenter(user: user, userId: user.id ?? .zero)
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: "detailUserViewController") as? DetailUserViewController else {return UIViewController()}
        
        let router = DetailUserRouter()
        router.navigationController = navigationController
        
        viewController.presenter = presenter
        viewController.presenter?.router = router
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = DetailUserInteractor(presenter: presenter, userId: userId)
        
        return viewController
    }
    
    func pushTo(view: DetailUserRouting) {
        switch view{
        case .detail(let album):
            let viewController = DetailAlbumRouter.createModule(using: navigationController, albumId: album.id ?? .zero, album: album)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        
    }
    
    
}
