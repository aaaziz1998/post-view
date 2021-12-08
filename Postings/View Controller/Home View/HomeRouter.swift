//
//  HomeRouter.swift
//  Postings
//
//  Created by Elabram MacbookPro on 05/12/21.
//

import Foundation
import UIKit

class HomeRouter: PresenterToRouterHomeProtocol{
    
    weak var navigationController: UINavigationController?
    
    static func createModule(using navigationController: UINavigationController?) -> UIViewController {
        let presenter: ViewToPresenterHomeProtocol & InteractorToPresenterHomeProtocol = HomePresenter()
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: "homeViewController") as? HomeViewController else {return UIViewController()}
        
        let router = HomeRouter()
        
        
        viewController.presenter = presenter
        viewController.presenter?.router = router
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = HomeInteractor(presenter: presenter)
        
        if let navigationController = navigationController{
            router.navigationController = navigationController
        } else {
            let navigationController = UINavigationController(rootViewController: viewController)
            
            router.navigationController = navigationController
            
            return navigationController
        }
        
        return viewController
    }
    
    func pushTo(view: HomeRouting) {
        switch view{
            
        case .detailPost(let post, let postBy, let listUser):
            let viewController = DetailPostRouter.createModule(using: navigationController, postBy: postBy, post: post, postId: post.id ?? .zero, listUser: listUser)
            self.navigationController?.pushViewController(viewController, animated: true)
        case .detailUser(let user):
            let viewController = DetailUserRouter.createModule(using: navigationController, userId: user.id ?? .zero, user: user)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}
