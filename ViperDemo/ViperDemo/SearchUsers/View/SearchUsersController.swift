//
//  SearchUsersController.swift
//  ViperDemo
//
//  Created by Adeel Tahir on 17/12/2022.
//

import UIKit

protocol SearchUsersViewProtocol {
    
    var presenter: SearchUsersPresenterProtocol? { get set }
    
    func updateUsersList(_ usersList: GithubUserList)
    func updateLoadingState(_ isLoading: Bool)
    func showError(_ error: HTTPError)
}

class SearchUsersController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    
    var presenter: SearchUsersPresenterProtocol?
    
    private var users = [GithubUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("")
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
}

extension SearchUsersController: SearchUsersViewProtocol {
    
    //MARK: SearchUsersViewProtocol
    func updateUsersList(_ usersList: GithubUserList) {
        users = usersList.items
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func updateLoadingState(_ isLoading: Bool) {
        
    }
    
    func showError(_ error: HTTPError) {
        
    }
}

extension SearchUsersController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as? UserTableViewCell {
            cell.configure(user: users[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectUser(user: users[indexPath.row].login)
    }
}

extension SearchUsersController: UITextFieldDelegate {
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presenter?.fetchUsersList(user: textField.text!)
        return true
    }
}
