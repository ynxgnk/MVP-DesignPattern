//
//  ViewController.swift
//  MVP DesignPatern
//
//  Created by Nazar Kopeika on 15.05.2023.
//

import UIKit

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UserPresenterDelegate { /* 34 add 2 protocols */ /* 44 add 1 protocol */

    private let tableView: UITableView = { /* 24 */
        let table = UITableView() /* 25 */
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell") /* 26 */
        return table /* 27 */
    }()
    
    private var users = [User]() /* 48 */
    
    private let presenter = UserPresenter() /* 42 */
    
    override func viewDidLoad() { 
        super.viewDidLoad()
        title = "Users" /* 1 */
        
        //Table
        view.addSubview(tableView) /* 28 */
        tableView.delegate = self /* 29 */
        tableView.dataSource = self /* 30 */
        
        //Presenter
        presenter.setViewDelegate(delegate: self) /* 43 */
        presenter.getUsers() /* 47 */
    }

    override func viewDidLayoutSubviews() { /* 31 */
        super.viewDidLayoutSubviews() /* 32 */
        tableView.frame = view.bounds /* 33 */
    }

    
    //Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { /* 35 */
        users.count /* 52 */
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { /* 36 */
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) /* 37 */
        cell.textLabel?.text = users[indexPath.row].name /* 38 */ /* 53 change "Hello" */
        return cell /* 39 */
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { /* 40 */
        tableView.deselectRow(at: indexPath, animated: true) /* 41 */
        //Ask presenter to handle the tap
        presenter.didTap(user: users[indexPath.row]) /* 55 */
    }
    
    //Presenter Delegate
    
    func presentUsers(users: [User]) { /* 45 */
        self.users = users /* 49 */
        
        DispatchQueue.main.async { /* 50 */
            self.tableView.reloadData() /* 51 */
        }
    }
    
    func presentAlert(title: String, message: String) { /* 46 */
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert) /* 57 */
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)) /* 57 */
        present(alert, animated: true) /* 58 */
    }
}


