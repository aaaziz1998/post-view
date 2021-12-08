//
//  DetailPostContractor.swift
//  Postings
//
//  Created by Elabram MacbookPro on 08/12/21.
//

import Foundation
import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewDetailPostProtocol: AnyObject {
    
    func successGetCommentIndex()
    func failureGetCommentIndex(message: String?)

}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterDetailPostProtocol: AnyObject {
    
    var view: PresenterToViewDetailPostProtocol? { get set }
    var interactor: PresenterToInteractorDetailPostProtocol? { get set }
    var router: PresenterToRouterDetailPostProtocol? { get set }
    
    var listComment: [Comment]? {get}
    var listUser: [User]? {get}
    var post: Post? {get}
    var postUser: User? {get}

    func viewDidLoad()
    func refreshData(loadMore: Bool)
    
    func selectRowAt(index: Int)
    
    func selectPostUser()
    
    func searchUser(email: String) -> User?
    
    func requestCommentIndex(loadMore: Bool)
    
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorDetailPostProtocol: AnyObject {
    
    var presenter: InteractorToPresenterDetailPostProtocol? { get set }

    func apiCommentIndex(parameters: [String: Any])
    
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterDetailPostProtocol: AnyObject {
    
    func successGetCommentIndex(response: [Comment])
    func failureGetCommentIndex(message: String)
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterDetailPostProtocol: AnyObject {
    
    static func createModule(using navigationController: UINavigationController?, postBy: User, post: Post, postId: Int, listUser: [User]) -> UIViewController
    func pushTo(view: DetailPostRouting)
}

enum DetailPostRouting{
    case detailUser(user: User)
}

