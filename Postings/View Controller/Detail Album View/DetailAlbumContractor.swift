//
//  DetailPhotoContractor.swift
//  Postings
//
//  Created by Elabram MacbookPro on 08/12/21.
//

import Foundation
import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewDetailAlbumProtocol: AnyObject {
    
    func successGetPhotoIndex()
    func failureGetPhotoIndex(message: String?)
    
    func share(url: URL)

}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterDetailAlbumProtocol: AnyObject {
    
    var view: PresenterToViewDetailAlbumProtocol? { get set }
    var interactor: PresenterToInteractorDetailAlbumProtocol? { get set }
    var router: PresenterToRouterDetailAlbumProtocol? { get set }
    
    var listPhoto: [Photo]? {get}
    var album: Album? {get}

    func viewDidLoad()
    func refreshData(loadMore: Bool)
    
    func selectRowAt(index: Int)
    
    func requestPhotoIndex(loadMore: Bool)
    
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorDetailAlbumProtocol: AnyObject {
    
    var presenter: InteractorToPresenterDetailAlbumProtocol? { get set }

    func apiPhotoIndex(parameters: [String: Any])
    func storeAndShareLabel(withURLString: String)
    
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterDetailAlbumProtocol: AnyObject {
    
    func successGetPhotoIndex(response: [Photo])
    func failureGetPhotoIndex(message: String)
    
    func share(url: URL)
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterDetailAlbumProtocol: AnyObject {
    
    static func createModule(using navigationController: UINavigationController?, albumId: Int, album: Album) -> UIViewController
    func pushTo(view: DetailAlbumRouting)
}

enum DetailAlbumRouting{
    case detail(id: Int)
}

