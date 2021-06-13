//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Алена Чимирис on 08.01.2021.
//  Copyright © 2021 Алена Чимирис. All rights reserved.
//

import UIKit


class ProgressCollectionViewCell: UICollectionViewCell {
    
    
    var progress: Float?
    
    var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "Все получится!"
        textLabel.textColor = .lightGray
        textLabel.font = UIFont.systemFont(ofSize: 16)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    
    var progressLabel: UILabel = {
        let progressLabel = UILabel()
        progressLabel.textColor = .lightGray
        progressLabel.text = "\(Int(HabitsStore.shared.todayProgress * 100))%"
        progressLabel.font = UIFont.systemFont(ofSize: 16)
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        return progressLabel
    }()
    
    
    var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = .purple
        progressView.setProgress(HabitsStore.shared.todayProgress, animated: true)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 4
        addSubview(textLabel)
        addSubview(progressLabel)
        addSubview(progressView)
        
        let constrains = [
            
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            textLabel.heightAnchor.constraint(equalToConstant: 20),
            
            progressLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            progressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            progressLabel.heightAnchor.constraint(equalToConstant: 20),
            
            progressView.topAnchor.constraint(equalTo: textLabel.bottomAnchor,constant: 10),
            progressView.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: progressLabel.trailingAnchor,constant: -16)
        ]
        
        NSLayoutConstraint.activate(constrains)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("oops")
    }
    
}

