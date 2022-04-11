//
//  Router.swift
//  VIPER-Design-Pattern
//
//  Created by Yilmaz Edis on 17.12.2021.
//

import Foundation
import UIKit

// object
// entry point, entrance of app

typealias UserEntryPoint = AnyUserView & UIViewController

protocol AnyUserRouter {

    var entry: UserEntryPoint? { get }

    static func start() -> AnyUserRouter
}

class UserRouter: AnyUserRouter {

    var entry: UserEntryPoint?

//    if you want to router another subrout
//    func stop()
//    func route(to destination)

    static func start() -> AnyUserRouter {
        let router = UserRouter()


        // Assign VIP

        var view: AnyUserView = UserViewController()
        var presenter: AnyUserPresenter = UserPresenter()
        var interactor: AnyUserInteractor = UserInteractor()

        view.presenter = presenter
        interactor.presenter = presenter

//        interactor.getUsers()

        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor

        router.entry = view as? UserEntryPoint

        return router
    }
}
