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
    
    var habitVC: HabitViewController?

    
    var habitTappedCompletion: (() -> Void)?
    
    var habit: Habit? {
        didSet {
            nameLabel.text = habit?.name
            colorView.backgroundColor = habit?.color
            timeLabel.text = habit?.dateString
            countLabel.text = ("Подряд: \(habit!.trackDates.count)")
        }
    }
    
    var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .black 
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    var colorView: UIView = {
        let colorView = UIView()
        colorView.layer.cornerRadius = 30/2
        colorView.clipsToBounds = true
        colorView.backgroundColor = .orange
        colorView.translatesAutoresizingMaskIntoConstraints = false
        return colorView
    }()
    
    var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.textColor = .lightGray
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeLabel
    }()
    
    var countLabel: UILabel = {
        let countLabel = UILabel()
        countLabel.textColor = .lightGray
        countLabel.text = "Подряд:"
        countLabel.font = UIFont.systemFont(ofSize: 12)
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        return countLabel
    }()
    
    let doneHabitMark: UIImageView = {
        let doneHabitMark = UIImageView()
        doneHabitMark.image = UIImage(named: "doneHabitMark")
        doneHabitMark.isHidden = true
        doneHabitMark.translatesAutoresizingMaskIntoConstraints = false
        return doneHabitMark
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       setupLayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("oops")
    }
    
    
    internal func configure(habitVC: HabitViewController) {
        self.habitVC = habitVC
        
        nameLabel.text = habitVC.textName.text
        colorView.backgroundColor = habitVC.viewColorPicker.backgroundColor
        timeLabel.text = habitVC.textTimePicker.text
        countLabel.text = ("Подряд: \(habit!.trackDates.count)")
       
    }
    
    @objc func tap() {
        
        // Проверяем что habit не nil
        guard let habit = self.habit else { return }
        // Проверяем, что привычка не была затрекана
        guard !habit.isAlreadyTakenToday else { return }
        // трекаем привычку
        HabitsStore.shared.track(habit)
        
        let animator = UIViewPropertyAnimator(duration: 0.8, curve: .linear) {
        
            self.colorView.layer.backgroundColor = UIColor.orange.cgColor
            self.doneHabitMark.isHidden = false
            self.contentView.layoutIfNeeded()
            self.contentView.reloadInputViews()
            
        }
        animator.startAnimation()
        
    }
    

    
    private func setupLayout() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        addSubview(nameLabel)
        addSubview(timeLabel)
        addSubview(colorView)
        addSubview(countLabel)
        addSubview(doneHabitMark)
        
        let tapMark = UITapGestureRecognizer(target: self, action: #selector(tap))
        colorView.addGestureRecognizer(tapMark)
        
        
        let constrains = [
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            timeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            countLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor,constant: 20),
            countLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            countLabel.heightAnchor.constraint(equalToConstant: 20),
            countLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            colorView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            colorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            colorView.widthAnchor.constraint(equalToConstant: 30),
            colorView.heightAnchor.constraint(equalToConstant: 30),
            
            doneHabitMark.centerYAnchor.constraint(equalTo: colorView.centerYAnchor),
            doneHabitMark.centerXAnchor.constraint(equalTo: colorView.centerXAnchor),
            doneHabitMark.widthAnchor.constraint(equalToConstant: 10),
            doneHabitMark.heightAnchor.constraint(equalToConstant: 10),
            
        ]
        
        NSLayoutConstraint.activate(constrains)
    }
    
}

