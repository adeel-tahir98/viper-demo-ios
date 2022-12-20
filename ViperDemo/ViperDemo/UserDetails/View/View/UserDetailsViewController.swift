//
//  UserDetailsViewController.swift
//  ViperDemo
//
//  Created by Adeel Tahir on 18/12/2022.
//

import UIKit
import SDWebImage

protocol UserDetailsViewProtocol {
    var presenter: UserDetailsPresenterProtocol? { get set }
    var userName: String? { get set }
    
    func updateUserDetails(userDetails: UserDetailsModel)
    func updateUserRepos(userRepos: [UserRepository])
    func updateUserFollowers(userFollowers: [UserFollower])
    func updateLoadingState(_ isLoading: Bool)
    func showError(_ error: HTTPError)
}

class UserDetailsViewController: UIViewController, UserDetailsViewProtocol {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var presenter: UserDetailsPresenterProtocol?
    var userName: String?

    var userDetails: UserDetailsModel?
    var repos = [UserRepository]()
    var followers = [UserFollower]()
    var userDetailsOptionHeaderView: UserDetailsOptionHeaderView?
    var selectedOption: DetailOption = .followers
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        if let userName = userName {
            presenter?.fetchUserDetails(user: userName)
            presenter?.fetchUserRepos(user: userName)
            presenter?.fetchUserFollowers(user: userName)
        }
    }
    
    private func setupUI() {
        navigationController?.isNavigationBarHidden = true

        profileImage.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        profileImage.layer.borderWidth = 5.0

        selectedOption = .followers
        userDetailsOptionHeaderView = Bundle.main.loadNibNamed("UserDetailsOptionHeaderView", owner: self, options: nil)?.first as? UserDetailsOptionHeaderView
        userDetailsOptionHeaderView!.delegate = self
        
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
    }
    
    private func reloadDetailsView() {
        if let userDetails = userDetails {
            if let name = userDetails.name {
                nameLabel.isHidden = false
                nameLabel.text = name
            } else {
                nameLabel.isHidden = true
            }
            if let login = userDetails.login {
                usernameLabel.isHidden = false
                usernameLabel.text = login
            } else {
                usernameLabel.isHidden = true
            }
            
            profileImage.sd_setImage(with: URL(string: userDetails.avatarURL)) { image, error, cacheType, url in
                if image != nil {
                    self.profileImage.image = image
                }
            }
            
            tableView.reloadData()
        }
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension UserDetailsViewController {
    
    func updateUserDetails(userDetails: UserDetailsModel) {
        DispatchQueue.main.async {
            self.userDetails = userDetails
            self.reloadDetailsView()
        }
    }
    
    func updateUserRepos(userRepos: [UserRepository]) {
        DispatchQueue.main.async {
            self.repos = userRepos
            self.tableView.reloadData()
        }
    }
    
    func updateUserFollowers(userFollowers: [UserFollower]) {
        DispatchQueue.main.async {
            self.followers = userFollowers
            self.tableView.reloadData()
        }
    }
    
    func updateLoadingState(_ isLoading: Bool) {
        
    }
    
    func showError(_ error: HTTPError) {
        
    }
}

extension UserDetailsViewController: UserDetailsOptionHeaderProtocol {
    func didSelect(_ option: DetailOption) {
        selectedOption = option
        tableView.reloadData()
    }
}

extension UserDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            if selectedOption == .repos {
                return repos.count
            } else if selectedOption == .followers {
                return followers.count
            }
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            if let userDetailsOptionHeaderView = userDetailsOptionHeaderView, let userDetails = userDetails {
                userDetailsOptionHeaderView.followersCountLabel.text = String(format: "%li", userDetails.followersCount)
                userDetailsOptionHeaderView.repositoriesCountLabel.text = String(format: "%li", userDetails.reposCount)
                return userDetailsOptionHeaderView
            }
        }
        return UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 90
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 90
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "UserDetailsCell") as? UserDetailsCell, let userDetails = userDetails {
                cell.configure(withDetails: userDetails)
                return cell
            }
        }
        else if indexPath.section == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as? UserTableViewCell {
                
                if selectedOption == .followers {
                    cell.configureFollower(follower: followers[indexPath.row])
                } else {
                    cell.configureRepo(repo: repos[indexPath.row])
                }
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
}
