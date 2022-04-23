//
//  TaskCell.swift
//  JustDoIt
//
//  Created by Павел Кривцов on 23.04.2022.
//

import UIKit

class TaskCell: UITableViewCell {
    
    static let reuseId = "TaskCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
