//
//  DetailPostRouter.swift
//  Postings
//
//  Created by Elabram MacbookPro on 08/12/21.
//

import Foundation
import UIKit

class DetailPostRouter: PresenterToRouterDetailPostProtocol{
    
    weak var navigationController: UINavigationController?
    
    static func createModule(using navigationController: UINavigationController?, postBy: User, post: Post, postId: Int, listUser: [User]) -> UIViewController {
        let presenter: ViewToPresenterDetailPostProtocol & InteractorToPresenterDetailPostProtocol = DetailPostPresenter(listUser: listUser, post: post, postUser: postBy)
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: "detailPostViewController") as? DetailPostViewController else {return UIViewController()}
        
        let router = DetailPostRouter()
        router.navigationController = navigationController
        
        viewController.presenter = presenter
        viewController.presenter?.router = router
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = DetailPostInteractor(presenter: presenter, postId: postId)
        
        return viewController
    }
    
    func pushTo(view: DetailPostRouting) {
        switch view{
        case .detailUser(let user):
            let viewController = DetailUserRouter.createModule(using: navigationController, userId: user.id ?? .zero, user: user)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    
}
