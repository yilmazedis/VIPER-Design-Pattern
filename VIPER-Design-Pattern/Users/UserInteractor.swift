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

// https://jsonplaceholder.typicode.com/users

protocol AnyUserInteractor {
    var presenter: AnyUserPresenter? { get set}

    func getUsers()

}

class UserInteractor: AnyUserInteractor {

    var presenter: AnyUserPresenter?

    func getUsers() {

        print("fetching")

        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in

            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                return
            }

            do {
                let entities = try JSONDecoder().decode([User].self, from: data)
                self?.presenter?.interactorDidFetchUsers(with: .success(entities))
            } catch {
                self?.presenter?.interactorDidFetchUsers(with: .failure(error))
            }

        }

        task.resume()
    }
    deinit {
        print("interactor")
    }
}
