//
//  SearchUsersPresenter.swift
//  ViperDemo
//
//  Created by Adeel Tahir on 17/12/2022.
//


// ref to Interactor, Router and View

import Foundation

protocol SearchUsersPresenterProtocol {
    var router: SearchUsersRouterProtocol? { get set }
    var view: SearchUsersViewProtocol? { get set }
    var interactor: SearchUsersInteractorProtocol? { get set }
    
    func fetchUsersList(user: String)
    func didSelectUser(user: String)
    
    func interactorDidFetchUsersList(_ usersList: GithubUserList)
    func interactorDidChangeLoadingState(_ isLoading: Bool)
    func interactorDidReceiveError(_ error: HTTPError)
}

class SearchUsersPresenter: SearchUsersPresenterProtocol {
    
    var router: SearchUsersRouterProtocol?
    
    var interactor: SearchUsersInteractorProtocol? {
        didSet {
            interactor?.fetchUsersList(user: "Adeel")
        }
    }
    
    var view: SearchUsersViewProtocol?
    
    init() {
        
    }
    
    func fetchUsersList(user: String) {
        interactor?.fetchUsersList(user: user)
    }
    
    func didSelectUser(user: String) {
        router?.routeToUserDetails(with: user)
    }
    
    func interactorDidFetchUsersList(_ usersList: GithubUserList) {
        view?.updateUsersList(usersList)
    }
    
    func interactorDidChangeLoadingState(_ isLoading: Bool) {
        view?.updateLoadingState(isLoading)
    }
    
    func interactorDidReceiveError(_ error: HTTPError) {
        view?.showError(error)
    }
}
