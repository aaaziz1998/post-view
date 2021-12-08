//
//  PostTableViewProgrammatically.swift
//  Postings
//
//  Created by Elabram MacbookPro on 07/12/21.
//

import Foundation
import UIKit

class PostTableViewProgrammatically: UITableViewCell{
    
    let postTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
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
        
        addSubview(postTitleLabel)
        
        NSLayoutConstraint.activate([
            postTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            postTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            postTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
        
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: postTitleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: postTitleLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor, constant: 10)
        ])
        
        addSubview(userImageView)
        
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: postTitleLabel.leadingAnchor),
            userImageView.heightAnchor.constraint(equalToConstant: 40),
            userImageView.widthAnchor.constraint(equalToConstant: 40),
            userImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            userImageView.bottomAnchor.constraint(equalTo: bottomAnchor,  constant: -10)
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
