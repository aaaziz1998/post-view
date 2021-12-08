//
//  DetailPostViewController.swift
//  Postings
//
//  Created by Elabram MacbookPro on 08/12/21.
//

import UIKit

class DetailPostViewController: UIViewController {
    
    var presenter: ViewToPresenterDetailPostProtocol?
    
    private let cellId = "cell"

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userFullName: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var postTextView: UITextView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Detail Post"
        
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: cellId)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        userImageView.image = UIImage(named: "\(presenter?.postUser?.id ?? .zero)")
        userFullName.text = presenter?.postUser?.name
        usernameLabel.text = presenter?.postUser?.company?.name
        
        postTextView.text = presenter?.post?.body
        
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        userImageView.isUserInteractionEnabled = true
        userFullName.isUserInteractionEnabled = true
        usernameLabel.isUserInteractionEnabled = true
        
        let userImageTapGesture = UITapGestureRecognizer(target: self, action: #selector(selectUser(sender:)))
        let userFullNameTapGesture = UITapGestureRecognizer(target: self, action: #selector(selectUser(sender:)))
        let usernameTapGesture = UITapGestureRecognizer(target: self, action: #selector(selectUser(sender:)))
        
        userImageView.addGestureRecognizer(userImageTapGesture)
        userFullName.addGestureRecognizer(userFullNameTapGesture)
        usernameLabel.addGestureRecognizer(usernameTapGesture)
    }
    
    @objc func selectUser(sender: UITapGestureRecognizer){
        presenter?.selectPostUser()
    }

}

extension DetailPostViewController: PresenterToViewDetailPostProtocol{
    
    func successGetCommentIndex() {
        tableView.reloadData()
    }
    
    func failureGetCommentIndex(message: String?) {
        
    }
    
}

extension DetailPostViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.listComment?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? CommentTableViewCell{
            
            if let comment = presenter?.listComment?[indexPath.row]{
                cell.commentBodyLabel.text = comment.body
                
                let initializerLabel = UILabel()
//                initializerLabel.frame.size = CGSize(width: self.frame.height, height: self.frame.height)
                initializerLabel.frame.size = CGSize(width: 50, height: 50)
                initializerLabel.textColor = UIColor.white
                initializerLabel.text = String(comment.email?.first ?? "A")
    
                initializerLabel.textAlignment = NSTextAlignment.center
                initializerLabel.backgroundColor = .lightGray
                initializerLabel.layer.cornerRadius = 25

                    UIGraphicsBeginImageContext(initializerLabel.frame.size)
                if let context = UIGraphicsGetCurrentContext(){
                    initializerLabel.layer.render(in: context)
                }
                cell.userImageView.image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
//                UIImage(named: "\(presenter?.searchUser(email: comment.email ?? "")?.id ?? .zero)")
                cell.usernameLabel.text = comment.name
                cell.userDescriptionLabel.text = comment.email
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectRowAt(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
