//
//  DetailUserContractor.swift
//  Postings
//
//  Created by Elabram MacbookPro on 07/12/21.
//

import Foundation
import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewDetailUserProtocol: AnyObject {
    
    func successGetAlbumIndex()
    func failureGetAlbumIndex(message: String?)

}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterDetailUserProtocol: AnyObject {
    
    var view: PresenterToViewDetailUserProtocol? { get set }
    var interactor: PresenterToInteractorDetailUserProtocol? { get set }
    var router: PresenterToRouterDetailUserProtocol? { get set }
    
    var listAlbum: [Album]? {get}
    var user: User? {get}

    func viewDidLoad()
    func refreshData(loadMore: Bool)
    
    func selectRowAt(index: Int)
    
    func requestAlbumIndex(loadMore: Bool)
    
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorDetailUserProtocol: AnyObject {
    
    var presenter: InteractorToPresenterDetailUserProtocol? { get set }

    func apiAlbumIndex(parameters: [String: Any])
    
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterDetailUserProtocol: AnyObject {
    
    func successGetAlbumIndex(response: [Album])
    func failureGetAlbumIndex(message: String)
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterDetailUserProtocol: AnyObject {
    
    static func createModule(using navigationController: UINavigationController?, userId: Int, user: User) -> UIViewController
    func pushTo(view: DetailUserRouting)
}

enum DetailUserRouting{
    case detail(album: Album)
}

