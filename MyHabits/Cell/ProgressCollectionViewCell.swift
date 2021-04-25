//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Алена Чимирис on 08.01.2021.
//  Copyright © 2021 Алена Чимирис. All rights reserved.
//

import UIKit


class ProgressCollectionViewCell: UICollectionViewCell {
    
    let cells =  HabitsStore.shared.todayProgress
    
    let store: HabitsStore = .shared
    

var textLabel: UILabel = {
    let textLabel = UILabel()
    textLabel.text = "Все получится!"
    textLabel.textColor = .gray
    textLabel.font = UIFont.systemFont(ofSize: 16)
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    return textLabel
}()

let progress = Int(HabitsStore.shared.todayProgress * 100)

var progressLabel: UILabel = {
    let progressLabel = UILabel()
    progressLabel.textColor = .gray
    progressLabel.text = "\(Int(HabitsStore.shared.todayProgress * 100))%"
    progressLabel.font = UIFont.systemFont(ofSize: 16)
    progressLabel.translatesAutoresizingMaskIntoConstraints = false
    return progressLabel
}()


var progressView: UIProgressView = {
    let progressView = UIProgressView()
    progressView.progressTintColor = .blue
    progressView.setProgress(HabitsStore.shared.todayProgress, animated: true)
    progressView.translatesAutoresizingMaskIntoConstraints = false
    return progressView
}()


override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(textLabel)
    addSubview(progressLabel)
    addSubview(progressView)
    
    let constrains = [
            
        textLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
        textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
        textLabel.heightAnchor.constraint(equalToConstant: 20),
        
        progressLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
//            progressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
         progressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
        progressLabel.heightAnchor.constraint(equalToConstant: 20),
        
        progressView.topAnchor.constraint(equalTo: textLabel.bottomAnchor,constant: 10),
        progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
        progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16)
        
    ]
    
    NSLayoutConstraint.activate(constrains)

}

required init?(coder aDecoder: NSCoder) {
    fatalError("oops")
}

}

private extension ProgressCollectionViewCell{
    func setupView() {
//        addSubview(textLabel)
//        addSubview(progressLabel)
//        addSubview(progressView)
//
//        let constrains = [
//
//            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
//            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
//            textLabel.heightAnchor.constraint(equalToConstant: 20),
//
//            progressLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
////            progressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
//             progressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
//            progressLabel.heightAnchor.constraint(equalToConstant: 20),
//
//            progressView.topAnchor.constraint(equalTo: textLabel.bottomAnchor,constant: 10),
//            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
//            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16)
//
//        ]
//
//        NSLayoutConstraint.activate(constrains)
//
//
    }
    
}
