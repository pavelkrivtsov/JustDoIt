//
//  ViewController.swift
//  JustDoIt
//
//  Created by Павел Кривцов on 23.04.2022.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    var tasks = [Task]()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let context = getContext()
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        do {
            tasks = try context.fetch(fetchRequest )
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    @objc private func addTask() {
        let addTaskController = UIAlertController(title: "Enter Task",
                                                  message: nil,
                                                  preferredStyle: .alert)
        addTaskController.addTextField { textField in }
        let cansel = UIAlertAction(title: "Cancel", style: .cancel)
        let add = UIAlertAction(title: "Add", style: .default) { action in
            let textf = addTaskController.textFields?.first
            if let task = textf?.text {
                self.saveTask(withTitle: task)
                self.tableView.reloadData()
            }
        }
        addTaskController.addAction(cansel)
        addTaskController.addAction(add)
        present(addTaskController, animated: true)
    }

    private func saveTask(withTitle title: String) {
        let context = getContext()
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        let taskObject = Task(entity: entity, insertInto: context)
        taskObject.title = title
        do {
            try context.save()
            tasks.append(taskObject)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    private func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
}

extension ViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseId, for: indexPath) as? TaskCell {
            let task = tasks[indexPath.row]
            var content = cell.defaultContentConfiguration()
            content.text = task.title
            cell.contentConfiguration = content
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    override func tableView(_ tableView: UITableView,
                            trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            let context = self.getContext()
            let task = self.tasks[indexPath.row]
            context.delete(task)

            do {
                try context.save()
                self.tasks = self.tasks.filter { $0 != task }
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        let swipe = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipe
    }
    
}
