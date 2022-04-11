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

protocol AnyTodoPresenter {
    var router: AnyTodoRouter? { get set }
    var interactor: AnyTodoInteractor? { get set}
    var view: AnyTodoView? { get set }

    func interactorDidFetchTodos(with result: Result<[Todo], Error>)
}

class TodoPresenter: AnyTodoPresenter {
    var router: AnyTodoRouter?

    var interactor: AnyTodoInteractor? {
        didSet {
            interactor?.getTodos()
        }
    }

    var view: AnyTodoView?

//    init() {
//        interactor?.getUsers()
//    }

    func interactorDidFetchTodos(with result: Result<[Todo], Error>) {
        switch result {
        case .success(let todo):
            view?.update(with: todo)
        case.failure:
            view?.update(with: "Something went wrong!")
        }
    }
    deinit {
        print("presenter")
    }
}
