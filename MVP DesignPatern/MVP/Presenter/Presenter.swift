//
//  Presenter.swift
//  MVP DesignPatern
//
//  Created by Nazar Kopeika on 15.05.2023.
//
import UIKit /* 6 */
import Foundation

protocol UserPresenterDelegate: AnyObject { /* 5 */
    func presentUsers(users: [User]) /* 10 */
    func presentAlert(title: String, message: String) /* 11 */
    
}

typealias PresenterDelegate = UserPresenterDelegate & UIViewController /* 8  */

class UserPresenter { /* 4 */
    weak var delegate: PresenterDelegate?
    
    public func getUsers() { /* 12 */
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return } /* 13 */
        let task = URLSession.shared.dataTask(with: url) { [weak self] data , _, error in /* 14 */ /* 22 add weak self */
            guard let data = data, error == nil else { /* 15 */
                return /* 16 */
            }
            do { /* 17 */
                let users = try JSONDecoder().decode([User].self, from: data) /* 18 */
                self?.delegate?.presentUsers(users: users) /* 23 */
            }
            catch { /* 19 */
                print(error) /* 20 */
            }
        }
        task.resume() /* 21 */
    }
    
    public func setViewDelegate(delegate: PresenterDelegate) { /* 7 */
        self.delegate = delegate /* 9 */
    }
    
    public func didTap(user: User) { /* 54 */
//        delegate?.presentAlert(title: user.name,
//                               message: "\(user.name) has an email of \(user.email) & a username of \(user.username)") /* 56 */
//
        let title = user.name /* 59 */
        let message = "\(user.name) has an email of \(user.email) & a username of \(user.username)" /* 60 */
        delegate?.presentAlert(title: user.name,
                               message: "\(user.name) has an email of \(user.email) & a username of \(user.username)") /* 61 */
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert) /* 64 */
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)) /* 62 */
        delegate?.present(alert, animated: true) /* 63 */
    }
}
