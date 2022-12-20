//
//  SearchUsersRouter.swift
//  ViperDemo
//
//  Created by Adeel Tahir on 17/12/2022.
//

// Entry Point

import Foundation
import UIKit

typealias SearchUsersEntryPoint = SearchUsersViewProtocol & UIViewController

protocol SearchUsersRouterProtocol {
    var entity: SearchUsersEntryPoint? { get }
    static func start() -> SearchUsersRouterProtocol
    
    func routeToUserDetails(with userName: String)
}

class SearchUsersRouter: SearchUsersRouterProtocol {
    var entity: SearchUsersEntryPoint?
    
    static func start() -> SearchUsersRouterProtocol {
        let router = SearchUsersRouter()
        
        var view: SearchUsersViewProtocol = UIStoryboard(name: "SearchUsers", bundle: nil).instantiateInitialViewController() as! SearchUsersController
        var presenter: SearchUsersPresenterProtocol = SearchUsersPresenter()
        var interator: SearchUsersInteractorProtocol = SearchUsersInteractor()
        
        view.presenter = presenter
        interator.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interator
        
        router.entity = view as? SearchUsersEntryPoint
        
        return router
    }
    
    func routeToUserDetails(with userName: String) {
        let userDetailsRouter = UserDetailsRouter.start(with: userName)
        let initialVC = userDetailsRouter.entity
        entity?.navigationController?.pushViewController(initialVC!, animated: true)
    }
}
