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
    var todos: [Todo]? { get set }

    func interactorDidFetchTodos(with result: Result<[Todo], Error>)
    func fetchData()
}

class TodoPresenter: AnyTodoPresenter {
    var router: AnyTodoRouter?
    var todos: [Todo]?
    var interactor: AnyTodoInteractor?
    var view: AnyTodoView?

    func fetchData() {
        interactor?.getTodos()
    }

    func interactorDidFetchTodos(with result: Result<[Todo], Error>) {
        switch result {
        case .success(let todo):
            view?.update(with: todo)
        case.failure:
            view?.update(with: "Something went wrong!")
        }
    }
}
