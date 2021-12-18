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

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {

    var entry: EntryPoint? { get }

    static func start() -> AnyRouter
}

class UserRouter: AnyRouter {

    var entry: EntryPoint?

//    if you want to router another subrout
//    func stop()
//    func route(to destination)

    static func start() -> AnyRouter {
        let router = UserRouter()


        // Assign VIP

        var view: AnyView = UserViewController()
        var presenter: AnyPresenter = UserPresenter()
        var interactor: AnyInteractor = UserInteractor()

        view.presenter = presenter
        interactor.presenter = presenter

//        interactor.getUsers()

        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor

        router.entry = view as? EntryPoint

        return router
    }


}
