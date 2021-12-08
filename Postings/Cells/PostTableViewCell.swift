//
//  PostTableViewCell.swift
//  Postings
//
//  Created by Elabram MacbookPro on 05/12/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    var delegate: PostTableViewCellDelegate?

    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userDescriptionLabel: UILabel!
    
    @IBOutlet weak var userStackView: UIStackView!
    
    @objc func tapUserDetail(sender: UITapGestureRecognizer) {
        delegate?.selectUser(index: sender.view?.tag ?? .zero)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapUserDetail(sender:)))
        userImageView.addGestureRecognizer(tapGesture)
//        addGestureRecognizer(tapGesture)
        //tapGesture.delegate = ViewController()
        
    }

    
}

protocol PostTableViewCellDelegate{
    
    func selectUser(index: Int)
    
}
