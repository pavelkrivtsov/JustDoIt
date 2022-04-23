//
//  ViewController.swift
//  JustDoIt
//
//  Created by Павел Кривцов on 23.04.2022.
//

import UIKit

class ViewController: UITableViewController {
    
    var tasks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "JustDoIt"
        let addTaskButton = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(addTask))
        navigationItem.rightBarButtonItem = addTaskButton
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseId)
    }
    
    @objc func addTask() {
        let addTaskController = UIAlertController(title: "Enter Task",
                                                  message: nil,
                                                  preferredStyle: .alert)
        addTaskController.addTextField { textField in }
        let cansel = UIAlertAction(title: "Cancel", style: .cancel)
        let add = UIAlertAction(title: "Add", style: .default) { action in
            let textf = addTaskController.textFields?.first
            if let newTask = textf?.text {
                self.tasks.append(newTask)
                self.tableView.reloadData()
            }
        }
        addTaskController.addAction(cansel)
        addTaskController.addAction(add)
        present(addTaskController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseId, for: indexPath) as? TaskCell {
            var content = cell.defaultContentConfiguration()
            content.text = tasks[indexPath.row]
            cell.contentConfiguration = content
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
}

