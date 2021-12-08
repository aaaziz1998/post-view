//
//  DetailAlbumViewController.swift
//  Postings
//
//  Created by Elabram MacbookPro on 08/12/21.
//

import UIKit
import Kingfisher

class DetailAlbumViewController: UIViewController {

    let cellId = "cell"
    
    var presenter: ViewToPresenterDetailAlbumProtocol?

    @IBOutlet weak var collectionView: UICollectionView!
    
    let documentInteractionController = UIDocumentInteractionController()
    
    private let collectionViewSectionLeftSpacing: CGFloat = 20
    private let collectionViewSectionRightSpacing: CGFloat = 20
    
    private let collectionViewCellSpacing: CGFloat = 5
    private let collectionViewNumberOfCellInRow: CGFloat = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Detail Album"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        documentInteractionController.delegate = self

        presenter?.viewDidLoad()
    }
    
}

extension DetailAlbumViewController: PresenterToViewDetailAlbumProtocol{
    
    func successGetPhotoIndex() {
        collectionView.reloadData()
    }
    
    func failureGetPhotoIndex(message: String?) {
        
    }
    
}

extension DetailAlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.listPhoto?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? PhotoCollectionViewCell{
            
            if let photo = presenter?.listPhoto?[indexPath.row]{
                do{
                    let options: KingfisherOptionsInfo = [.keepCurrentImageWhileLoading,
                                                          .scaleFactor(UIScreen.main.scale),
                                                          .transition(.fade(1)),
                                                          .cacheOriginalImage]
                    cell.photoImageView.kf.setImage(with: try photo.thumbnailUrl?.asURL(), options: options, completionHandler:  { (kingfisher) in
                        // completion
                    })
                } catch _ {
                    let initializerLabel = UILabel()
    //                initializerLabel.frame.size = CGSize(width: self.frame.height, height: self.frame.height)
                    initializerLabel.frame.size = CGSize(width: 50, height: 50)
                    initializerLabel.textColor = UIColor.white
                    initializerLabel.text = String(photo.title?.first ?? "A")
        
                    initializerLabel.textAlignment = NSTextAlignment.center
                    initializerLabel.backgroundColor = .lightGray
                    initializerLabel.layer.cornerRadius = 25

                        UIGraphicsBeginImageContext(initializerLabel.frame.size)
                    if let context = UIGraphicsGetCurrentContext(){
                        initializerLabel.layer.render(in: context)
                    }
                    cell.photoImageView.image = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()

                }
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let separatorCell = collectionViewCellSpacing * collectionViewNumberOfCellInRow
        let width = (self.view.frame.width - collectionViewSectionLeftSpacing - collectionViewSectionRightSpacing - separatorCell) / collectionViewNumberOfCellInRow
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.selectRowAt(index: indexPath.row)
    }
    
}

extension DetailAlbumViewController: UIDocumentInteractionControllerDelegate{
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        if let navVC = self.navigationController {
            navVC.navigationBar.isHidden = false
            return navVC
        }
        
        return self
    }
    
    func share(url: URL) {
        documentInteractionController.url = url
        documentInteractionController.uti = url.typeIdentifier ?? "public.data, public.content"
        documentInteractionController.name = url.localizedName ?? url.lastPathComponent
        documentInteractionController.presentPreview(animated: true)
    }
    
}

