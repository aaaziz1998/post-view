//
//  ViewController.swift
//  Postings
//
//  Created by Elabram MacbookPro on 05/12/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    let cellId = "cell"
    let cellIdProgrammatically = "cell_programmatically"
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: ViewToPresenterHomeProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(PostTableViewProgrammatically.self, forCellReuseIdentifier: cellIdProgrammatically)
        tableView.delegate = self
        tableView.dataSource = self
        
        title = "Home"
        
        presenter.viewDidLoad()
    }
    
    @objc func parentSelectUser(index: Int){
        presenter.selectRowAt(index: index)
    }
    
    @objc func selectUser(sender: UITapGestureRecognizer){
        presenter.selectUserRowAt(index: sender.view?.tag ?? .zero)
    }

}

extension HomeViewController: PresenterToViewHomeProtocol{
    
    func successGetUserIndex() {
        
    }
    
    func failureGetUserIndex(message: String?) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let btnRefresh = UIAlertAction(title: "Refresh", style: .default) { action in
            self.presenter.refreshData(loadMore: false)
        }
        let btnCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(btnCancel)
        alert.addAction(btnRefresh)
        
        present(alert, animated: true, completion: nil)
    }
    
    func successGetHomeIndex() {
        tableView.reloadData()
    }
    
    func failureGetHomeIndex(message: String?) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let btnRefresh = UIAlertAction(title: "Refresh", style: .default) { action in
            self.presenter.refreshData(loadMore: false)
        }
        let btnCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(btnCancel)
        alert.addAction(btnRefresh)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdProgrammatically) as? PostTableViewProgrammatically{
            cell.contentView.isUserInteractionEnabled = false
            
            if let post = presenter.listPosts?[indexPath.row],
               let user = presenter.searchUser(id: post.userId ?? .zero){
                cell.postTitleLabel.text = post.title
                cell.descriptionLabel.text = post.body
                
                cell.usernameLabel.text = user.name
                cell.usernameLabel.isUserInteractionEnabled = true
                
                cell.userDescriptionLabel.text = user.company?.name
                cell.userDescriptionLabel.isUserInteractionEnabled = true
                
                cell.userImageView.image = UIImage(named: String(user.id ?? .zero))
                cell.userImageView.layer.cornerRadius = 20
                cell.userImageView.isUserInteractionEnabled = true
                cell.userImageView.backgroundColor = .cyan
                
                cell.userImageView.tag = indexPath.row
                cell.usernameLabel.tag = indexPath.row
                cell.userDescriptionLabel.tag = indexPath.row
                cell.userStackView.tag = indexPath.row
                
                
                let userSelectedTapGesture = UITapGestureRecognizer(target: self, action: #selector(selectUser(sender: )))
                cell.userImageView.addGestureRecognizer(userSelectedTapGesture)
                
                let userNameTapGesture = UITapGestureRecognizer(target: self, action: #selector(selectUser(sender: )))
                cell.usernameLabel.addGestureRecognizer(userNameTapGesture)
                
                let userDescriptionTapGesture = UITapGestureRecognizer(target: self, action: #selector(selectUser(sender: )))
                cell.userDescriptionLabel.addGestureRecognizer(userDescriptionTapGesture)


            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.isUserInteractionEnabled = false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.listPosts?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectRowAt(index: indexPath.row)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension HomeViewController: PostTableViewCellDelegate{
    
    func selectUser(index: Int) {
        self.parentSelectUser(index: index)
    }
    
}



