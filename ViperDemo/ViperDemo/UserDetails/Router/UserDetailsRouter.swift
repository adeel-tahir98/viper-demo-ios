//
//  UserDetailsRouter.swift
//  ViperDemo
//
//  Created by Adeel Tahir on 18/12/2022.
//

import Foundation
import UIKit

typealias UserDetailsEntryPoint = UserDetailsViewProtocol & UIViewController

protocol UserDetailsRouterProtocol {
    var entity: UserDetailsEntryPoint? { get }
    static func start(with userName: String) -> UserDetailsRouterProtocol
}

class UserDetailsRouter: UserDetailsRouterProtocol {
    var entity: UserDetailsEntryPoint?
    
    static func start(with userName: String) -> UserDetailsRouterProtocol {
        let router = UserDetailsRouter()
        
        var view: UserDetailsViewProtocol = UIStoryboard(name: "UserDetails", bundle: nil).instantiateInitialViewController() as! UserDetailsViewController
        view.userName = userName
        var presenter: UserDetailsPresenterProtocol = UserDetailsPresenter()
        var interator: UserDetailsInteractorProtocol = UserDetailsInteractor()
        
        view.presenter = presenter
        interator.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interator
        
        router.entity = view as? UserDetailsEntryPoint
        
        return router
    }
}
