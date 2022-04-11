//
//  View.swift
//  VIPER-Design-Pattern
//
//  Created by Yilmaz Edis on 17.12.2021.
//

import Foundation
import UIKit

// ViewController
// protocol
// reference presenter

protocol AnyTodoView {
    var presenter: AnyTodoPresenter? { get set }

    func update(with todos: [Todo])
    func update(with error: String)
}

class TodoViewController: UIViewController, AnyTodoView, UITableViewDelegate, UITableViewDataSource {
    var presenter: AnyTodoPresenter?

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()

    var todos: [Todo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(label)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        configureNavbar()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
    }

    private func configureNavbar() {
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil)

        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]

        navigationController?.navigationBar.tintColor = .brown
    }

    @objc func addTapped() {
        
    }

    func update(with todos: [Todo]) {
        print("Starting")
        DispatchQueue.main.async {
            self.todos = todos
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }

    func update(with error: String) {
        DispatchQueue.main.async {
            self.todos = []
            self.label.text = error
            self.tableView.isHidden = true
            self.label.isHidden = false
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = todos[indexPath.row].title

        return cell
    }

    deinit {
        print("view")
    }

}
