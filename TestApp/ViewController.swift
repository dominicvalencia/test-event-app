//
//  ViewController.swift
//  TestApp
//
//  Created by Domini Valencia on 11/25/24.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    var realm = try! Realm()
    
    let button1: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Button 1", for: .normal)
        button.backgroundColor = .red
        button.tag = 1
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private let button2: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Button 2", for: .normal)
        button.backgroundColor = .blue
        button.tag = 2
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private let button3: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Button 3", for: .normal)
        button.backgroundColor = .green
        button.tag = 3
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private let button4: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Button 4", for: .normal)
        button.backgroundColor = .yellow
        button.tag = 4
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [button1, button2, button3, button4])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        let event = Event()
        event.id = UUID().uuidString
        event.buttonId = sender.tag
        event.timestamp = Date()
        
        saveEventToRealm(event)
    }
    
    private func saveEventToRealm(_ event: Event) {
        do {
            try realm.write {
                realm.add(event)
            }
        } catch {
            print("Error saving event: \(error.localizedDescription)")
        }
        
        navigateToEventList()
    }
    
    private func navigateToEventList() {
        let eventListVC = EventListViewController()
        navigationController?.pushViewController(eventListVC, animated: true)
    }
}

