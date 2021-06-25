//
//  HabitDetailsViewControllerCell.swift
//  MyHabits
//
//  Created by Алёна Чимирис on 21.05.2021.
//  Copyright © 2021 Алена Чимирис. All rights reserved.
//

import UIKit

class HabitDetailsTableCell: UITableViewCell {
    
    
    var trackDay: UILabel = {
        let trackDay = UILabel()
        trackDay.translatesAutoresizingMaskIntoConstraints = false
        return trackDay
    }()
    
    var doneHabitMark: UILabel = {
        let doneHabitMark = UILabel()
        doneHabitMark.textColor = .purple
        doneHabitMark.text = "✓"
        doneHabitMark.textAlignment = .right
        doneHabitMark.isHidden = true
        doneHabitMark.translatesAutoresizingMaskIntoConstraints = false
        return doneHabitMark
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupLayout(){
        contentView.addSubview(trackDay)
        contentView.addSubview(doneHabitMark)
        
        let constrains = [
            
            trackDay.topAnchor.constraint(equalTo: contentView.topAnchor),
            trackDay.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            trackDay.heightAnchor.constraint(equalToConstant: 40),
            trackDay.widthAnchor.constraint(equalToConstant: 50),
            trackDay.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            doneHabitMark.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            doneHabitMark.leadingAnchor.constraint(equalTo: trackDay.leadingAnchor, constant: 30),
            doneHabitMark.widthAnchor.constraint(equalToConstant: 15),
            doneHabitMark.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
        ]
        
        NSLayoutConstraint.activate(constrains)
        
    }
    
}
