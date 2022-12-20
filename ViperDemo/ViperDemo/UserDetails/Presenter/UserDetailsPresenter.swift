//
//  UserDetailsPresenter.swift
//  ViperDemo
//
//  Created by Adeel Tahir on 18/12/2022.
//

import Foundation

protocol UserDetailsPresenterProtocol {
    var router: UserDetailsRouterProtocol? { get set }
    var view: UserDetailsViewProtocol? { get set }
    var interactor: UserDetailsInteractorProtocol? { get set }
    
    func fetchUserDetails(user: String)
    func fetchUserRepos(user: String)
    func fetchUserFollowers(user: String)
    
    func interactorDidFetchUsersDetails(_ userDetails: UserDetailsModel)
    func interactorDidFetchUsersRepos(_ userRepos: [UserRepository])
    func interactorDidFetchUsersFollowers(_ userFollowers: [UserFollower])
    func interactorDidChangeLoadingState(_ isLoading: Bool)
    func interactorDidReceiveError(_ error: HTTPError)
}

class UserDetailsPresenter: UserDetailsPresenterProtocol {

    var router: UserDetailsRouterProtocol?
    
    var interactor: UserDetailsInteractorProtocol? {
        didSet {
        }
    }
    
    var view: UserDetailsViewProtocol?
    
    init() {
        
    }
    
    func fetchUserDetails(user: String) {
        interactor?.fetchUserDetails(user: user)
    }
    
    func fetchUserRepos(user: String) {
        interactor?.fetchUserRepos(user: user)
    }
    
    func fetchUserFollowers(user: String) {
        interactor?.fetchUserFollowers(user: user)
    }
    
    func interactorDidFetchUsersDetails(_ userDetails: UserDetailsModel) {
        view?.updateUserDetails(userDetails: userDetails)
    }
    
    func interactorDidFetchUsersRepos(_ userRepos: [UserRepository]) {
        view?.updateUserRepos(userRepos: userRepos)
    }
    
    func interactorDidFetchUsersFollowers(_ userFollowers: [UserFollower]) {
        view?.updateUserFollowers(userFollowers: userFollowers)
    }
    
    func interactorDidChangeLoadingState(_ isLoading: Bool) {
        view?.updateLoadingState(isLoading)
    }
    
    func interactorDidReceiveError(_ error: HTTPError) {
        view?.showError(error)
    }
}
