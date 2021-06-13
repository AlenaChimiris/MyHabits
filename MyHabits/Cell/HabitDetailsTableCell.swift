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
        doneHabitMark.text = "yes"
        //        doneHabitMark.textAlignment = .right
        doneHabitMark.translatesAutoresizingMaskIntoConstraints = false
        return doneHabitMark
    }()
    
    
    
    func setupViews() {
        addSubview(trackDay)
        addSubview(doneHabitMark)
        
        
        let constrains = [
            
            trackDay.topAnchor.constraint(equalTo: contentView.topAnchor),
            trackDay.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 30),
            trackDay.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            //            trackDay.heightAnchor.constraint(equalToConstant: 30),
            trackDay.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            doneHabitMark.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 25),
            doneHabitMark.leadingAnchor.constraint(equalTo:  contentView.leadingAnchor,constant: 30),
            doneHabitMark.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -12),
            doneHabitMark.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -30)
            
        ]
        
        NSLayoutConstraint.activate(constrains)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
