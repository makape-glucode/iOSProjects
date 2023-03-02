//
//  ToDoCell.swift
//  toDoList
//
//  Created by Makape Tema on 2023/03/01.
//

import UIKit

class ToDoCell: UITableViewCell {

    @IBOutlet weak var theLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dueDateLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        dueDateLabel.textColor = .lightGray
    }

    
    
}
