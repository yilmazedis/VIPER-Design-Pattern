//
//  Presenter.swift
//  VIPER-Design-Pattern
//
//  Created by Yilmaz Edis on 17.12.2021.
//

import Foundation

// object
// protocol
// ref to interactor, router, view

enum FetchError: Error {
    case failed
}

protocol AnyUserPresenter {
    var router: AnyUserRouter? { get set }
    var interactor: AnyUserInteractor? { get set }
    var view: AnyUserView? { get set }
    var users: [User]? { get set }

    func interactorDidFetchUsers(with result: Result<[User], Error>)
}

class UserPresenter: AnyUserPresenter {
    var users: [User]?
    var router: AnyUserRouter?
    var view: AnyUserView?
    var interactor: AnyUserInteractor? {
        didSet {
            interactor?.getUsers()
        }
    }

//    init() {
//        interactor?.getUsers()
//    }

    func interactorDidFetchUsers(with result: Result<[User], Error>) {
        switch result {
        case .success(let users):
            view?.update(with: users)
        case.failure:
            view?.update(with: "Something went wrong!")
        }
    }
}
