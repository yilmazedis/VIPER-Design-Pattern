//
//  Interactor.swift
//  VIPER-Design-Pattern
//
//  Created by Yilmaz Edis on 17.12.2021.
//

import Foundation

// object
// protocol
// ref to presenter

// https://jsonplaceholder.typicode.com/todos

protocol AnyTodoInteractor {
    var presenter: AnyTodoPresenter? { get set}

    func getTodos()

}

class TodoInteractor: AnyTodoInteractor {

    var presenter: AnyTodoPresenter?

    func getTodos() {

        print("fetching")

        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in

            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchTodos(with: .failure(FetchError.failed))
                return
            }

            do {
                let entities = try JSONDecoder().decode([Todo].self, from: data)
                self?.presenter?.interactorDidFetchTodos(with: .success(entities))
            } catch {
                self?.presenter?.interactorDidFetchTodos(with: .failure(error))
            }

        }

        task.resume()
    }
    deinit {
        print("interactor")
    }
}
