//
//  UserDetailsInteractor.swift
//  ViperDemo
//
//  Created by Adeel Tahir on 18/12/2022.
//

import Foundation

protocol UserDetailsInteractorProtocol {
    var presenter: UserDetailsPresenterProtocol? { get set}
    
    func fetchUserDetails(user: String)
    func fetchUserRepos(user: String)
    func fetchUserFollowers(user: String)
}

class UserDetailsInteractor: UserDetailsInteractorProtocol {
    var presenter: UserDetailsPresenterProtocol?
 
    func fetchUserDetails(user: String) {
        APIGeneric<UserDetailsModel>.fetchRequest(apiURL: API.kUserDetails.replacingOccurrences(of: "{username}", with: user)) { [weak self] resource in
            guard let `self` = self else {return}
            switch resource.state {
            case .loading:
                self.presenter?.interactorDidChangeLoadingState(true)
                
            case .success:
                self.presenter?.interactorDidChangeLoadingState(false)
                if let data = resource.data {
                    self.presenter?.interactorDidFetchUsersDetails(data)
                }
                
            case .failure:
                self.presenter?.interactorDidChangeLoadingState(false)
                if let error = resource.error {
                    self.presenter?.interactorDidReceiveError(error)
                }
            }
        }
    }
    
    func fetchUserRepos(user: String) {
        APIGeneric<[UserRepository]>.fetchRequest(apiURL: API.kUserReposAPI.replacingOccurrences(of: "{username}", with: user)) { [weak self] resource in
            guard let `self` = self else {return}
            switch resource.state {
            case .loading:
                self.presenter?.interactorDidChangeLoadingState(true)
                
            case .success:
                self.presenter?.interactorDidChangeLoadingState(false)
                if let data = resource.data {
                    self.presenter?.interactorDidFetchUsersRepos(data)
                }
                
            case .failure:
                self.presenter?.interactorDidChangeLoadingState(false)
                if let error = resource.error {
                    self.presenter?.interactorDidReceiveError(error)
                }
            }
        }
    }
    
    func fetchUserFollowers(user: String) {
        APIGeneric<[UserFollower]>.fetchRequest(apiURL: API.kUserFollowersAPI.replacingOccurrences(of: "{username}", with: user)) { [weak self] resource in
            guard let `self` = self else {return}
            switch resource.state {
            case .loading:
                self.presenter?.interactorDidChangeLoadingState(true)
                
            case .success:
                self.presenter?.interactorDidChangeLoadingState(false)
                if let data = resource.data {
                    self.presenter?.interactorDidFetchUsersFollowers(data)
                }
                
            case .failure:
                self.presenter?.interactorDidChangeLoadingState(false)
                if let error = resource.error {
                    self.presenter?.interactorDidReceiveError(error)
                }
            }
        }
    }
}

