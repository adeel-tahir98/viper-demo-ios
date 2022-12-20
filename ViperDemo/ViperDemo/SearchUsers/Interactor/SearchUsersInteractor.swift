//
//  SearchUsersInteractor.swift
//  ViperDemo
//
//  Created by Adeel Tahir on 17/12/2022.
//

// ref to Presenter

import Foundation

protocol SearchUsersInteractorProtocol {
    
    var presenter: SearchUsersPresenterProtocol? { get set}
    
    func fetchUsersList(user:String)
    func fetchUsersSuggestions(user: String)
    func fetchUsersList(user: String, maxItems: String, isLoadingMore: Bool)
}

class SearchUsersInteractor: SearchUsersInteractorProtocol {
    var presenter: SearchUsersPresenterProtocol?
    
    func fetchUsersList(user: String) {
        fetchUsersList(user: user, maxItems: "30", isLoadingMore: false)
    }
    
    func fetchUsersSuggestions(user: String) {
        
    }
    
    func fetchUsersList(user: String, maxItems: String, isLoadingMore: Bool) {
        APIGeneric<GithubUserList>.fetchRequest(apiURL: API.kSearchUsers.replacingOccurrences(of: "{username}", with: user).replacingOccurrences(of: "{maxItems}", with: maxItems).replacingOccurrences(of: "{pageNumber}", with: "1")) { [weak self] resource in
            guard let `self` = self else {return}
            switch resource.state {
            case .loading:
                self.presenter?.interactorDidChangeLoadingState(true)
                
            case .success:
                self.presenter?.interactorDidChangeLoadingState(false)
                if let data = resource.data {
                    self.presenter?.interactorDidFetchUsersList(data)
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
