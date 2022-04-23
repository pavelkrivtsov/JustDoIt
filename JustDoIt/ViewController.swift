//
//  ViewController.swift
//  JustDoIt
//
//  Created by Павел Кривцов on 23.04.2022.
//

import UIKit

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "JustDoIt"
        let addTaskButton = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(addTask))
        navigationItem.rightBarButtonItem = addTaskButton
    }
    
    @objc func addTask() {
        let addTaskController = UIAlertController(title: "Enter Task",
                                                  message: nil,
                                                  preferredStyle: .alert)
        addTaskController.addTextField { textField in
            
        }
        let cansel = UIAlertAction(title: "Cansel", style: .cancel)
        let add = UIAlertAction(title: "Add", style: .default) { action in
            
        }
        addTaskController.addAction(cansel)
        addTaskController.addAction(add)
        present(addTaskController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
}

