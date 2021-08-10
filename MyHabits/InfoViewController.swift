//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Алена Чимирис on 04.01.2021.
//  Copyright © 2021 Алена Чимирис. All rights reserved.
//

import UIKit

class InfoViewController: ViewController {
    
    let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var lebelView: UILabel = {
        let lebelView = UILabel()
        lebelView.translatesAutoresizingMaskIntoConstraints = false
        lebelView.text = "Привычка за 21 день"
        lebelView.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        lebelView.textColor = .black
        return lebelView
    }()
    
    var textView: UILabel = {
        let textView = UILabel ()
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.numberOfLines = 0
        textView.text = "Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:  \n1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.  \n2. Выдержать 2 дня в прежнем состоянии самоконтроля.   \n3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться.  \n4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.  \n5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.  \n6.  На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.  \n Источник: psychbook.ru"
        return textView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(type(of: self), #function)
        
        view.addSubview(scrollView)
        view.backgroundColor = .white
        navigationItem.title = "Информация"
        navigationItem.leftBarButtonItem?.tintColor = .purple
        setupLayout()
    }
    
    private func setupLayout(){
        scrollView.addSubview(contentView)
        contentView.addSubview(lebelView)
        contentView.addSubview(textView)
        
        let constr = [
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            lebelView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            lebelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            lebelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            lebelView.heightAnchor.constraint(equalToConstant: 20),
            
            textView.topAnchor.constraint(equalTo: lebelView.bottomAnchor, constant: 16),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            
        ]
        
        NSLayoutConstraint.activate(constr)
        
    }

    
}
