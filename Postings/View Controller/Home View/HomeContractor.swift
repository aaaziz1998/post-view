//
//  HomeContractor.swift
//  Postings
//
//  Created by Elabram MacbookPro on 05/12/21.
//

import Foundation
import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewHomeProtocol: AnyObject {
    
    func successGetHomeIndex()
    func failureGetHomeIndex(message: String?)
    
    func successGetUserIndex()
    func failureGetUserIndex(message: String?)

}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterHomeProtocol: AnyObject {
    
    var view: PresenterToViewHomeProtocol? { get set }
    var interactor: PresenterToInteractorHomeProtocol? { get set }
    var router: PresenterToRouterHomeProtocol? { get set }
    
    var listPosts: [Post]? {get}
    var listUsers: [User]? {get}

    func viewDidLoad()
    func refreshData(loadMore: Bool)
    func selectRowAt(index: Int)
    func selectUserRowAt(index: Int)
    
    func searchUser(id: Int) -> User?
    
    func requestPostIndex(loadMore: Bool)
    
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorHomeProtocol: AnyObject {
    
    var presenter: InteractorToPresenterHomeProtocol? { get set }

    func apiPostIndex(loadMore: Bool, parameters: [String: Any])
    func apiUserIndex(parameters: [String: Any])
    
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterHomeProtocol: AnyObject {
    
    func successHomeIndex(loadMore: Bool, response: [Post])
    func failureHomeIndex(message: String)
    
    func successUserIndex(response: [User])
    func failureUserIndex(message: String)
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterHomeProtocol: AnyObject {
    
    static func createModule(using navigationController: UINavigationController?) -> UIViewController
    func pushTo(view: HomeRouting)
}

enum HomeRouting{
    case detailPost(post: Post, postBy: User, listUser: [User])
    case detailUser(user: User)
}

