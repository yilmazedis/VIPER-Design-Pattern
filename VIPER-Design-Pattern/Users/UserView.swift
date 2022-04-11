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

protocol AnyUserView {
    var presenter: AnyUserPresenter? { get set }

    func update(with users: [User])
    func update(with error: String)
}

class UserViewController: UIViewController, AnyUserView, UITableViewDelegate, UITableViewDataSource {
    var presenter: AnyUserPresenter?

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
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: #selector(addTapped))

        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]

        navigationController?.navigationBar.tintColor = .brown
    }

    @objc func addTapped() {
        let todoRouter = TodoRouter.start()

        let initialVC = (todoRouter.entry)!

        navigationController?.pushViewController(initialVC, animated: true)
    }

    func update(with users: [User]) {
        print("Starting")
        DispatchQueue.main.async {
            self.presenter?.users = users
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }

    func update(with error: String) {
        DispatchQueue.main.async {
            self.presenter?.users = []
            self.label.text = error
            self.tableView.isHidden = true
            self.label.isHidden = false
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.users?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = presenter?.users?[indexPath.row].name

        return cell
    }
}
