//
//  CommentTableViewCell.swift
//  Postings
//
//  Created by Elabram MacbookPro on 08/12/21.
//

import Foundation
import UIKit

class CommentTableViewCell: UITableViewCell{
    
    let commentBodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 10
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    let userDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    var userStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(userImageView)
        
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            userImageView.heightAnchor.constraint(equalToConstant: 40),
            userImageView.widthAnchor.constraint(equalToConstant: 40),
            userImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
//            userImageView.bottomAnchor.constraint(equalTo: bottomAnchor,  constant: -10)
        ])
        
        userStackView = UIStackView(arrangedSubviews: [usernameLabel, userDescriptionLabel])
        userStackView.translatesAutoresizingMaskIntoConstraints = false
        userStackView.axis = .vertical
        userStackView.spacing = 2
        userStackView.alignment = .leading
        
        addSubview(userStackView)
        
        NSLayoutConstraint.activate([
            userStackView.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            userStackView.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 10),
            userStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        addSubview(commentBodyLabel)
        
        NSLayoutConstraint.activate([
            commentBodyLabel.leadingAnchor.constraint(equalTo: userImageView.leadingAnchor),
            commentBodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            commentBodyLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 5),
            commentBodyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
