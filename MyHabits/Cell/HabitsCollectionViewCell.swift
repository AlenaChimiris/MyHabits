//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Алена Чимирис on 08.01.2021.
//  Copyright © 2021 Алена Чимирис. All rights reserved.
//

import UIKit

class HabitsCollectionViewCell: UICollectionViewCell {

    
    let habitCell = HabitsStore.shared.habits
    
      var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .blue
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()

      var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.textColor = .lightGray
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("oops")
    }
    
}

private extension HabitsCollectionViewCell{
    func setupView() {
        addSubview(nameLabel)
        addSubview(timeLabel)
        
        let constrains = [
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
//          nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            timeLabel.heightAnchor.constraint(equalToConstant: 20),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ]
        
        NSLayoutConstraint.activate(constrains)
        
    }
}
