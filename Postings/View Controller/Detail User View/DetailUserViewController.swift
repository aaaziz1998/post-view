//
//  DetailUserViewController.swift
//  Postings
//
//  Created by Elabram MacbookPro on 07/12/21.
//

import UIKit
import Kingfisher

class DetailUserViewController: UIViewController {
    
    private let cellId = "cell"
    
    private let collectionViewSectionLeftSpacing: CGFloat = 20
    private let collectionViewSectionRightSpacing: CGFloat = 20
    
    private let collectionViewCellSpacing: CGFloat = 5
    private let collectionViewNumberOfCellInRow: CGFloat = 3

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: ViewToPresenterDetailUserProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Detail User"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        userImageView.image = UIImage(named: "\(presenter?.user?.id ?? .zero)")
        userFullNameLabel.text = presenter?.user?.name
        usernameLabel.text = presenter?.user?.username
        
        presenter?.viewDidLoad()
    }

}

extension DetailUserViewController: PresenterToViewDetailUserProtocol{
    
    func successGetAlbumIndex() {
        collectionView.reloadData()
    }
    
    func failureGetAlbumIndex(message: String?) {
        
    }
    
    
}

extension DetailUserViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.listAlbum?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? AlbumCollectionViewCell{
            if let album = presenter?.listAlbum?[indexPath.row]{
                
                cell.albumImageView.layer.cornerRadius = 10
                cell.albumImageView.backgroundColor = .cyan
                cell.albumTitleLabel.text = album.title
                
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
