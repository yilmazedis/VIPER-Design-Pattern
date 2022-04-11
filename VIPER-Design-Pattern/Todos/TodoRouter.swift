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

typealias TodoEntryPoint = AnyTodoView & UIViewController

protocol AnyTodoRouter {

    var entry: TodoEntryPoint? { get }

    static func start() -> AnyTodoRouter
}

class TodoRouter: AnyTodoRouter {

    var entry: TodoEntryPoint?

//    if you want to router another subrout
//    func stop()
//    func route(to destination)

    static func start() -> AnyTodoRouter {
        let router = TodoRouter()


        // Assign VIP

        var view: AnyTodoView = TodoViewController()
        var presenter: AnyTodoPresenter = TodoPresenter()
        var interactor: AnyTodoInteractor = TodoInteractor()

        view.presenter = presenter
        interactor.presenter = presenter

//        interactor.getUsers()

        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor

        router.entry = view as? TodoEntryPoint

        return router
    }
}
