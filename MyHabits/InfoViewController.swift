//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Алена Чимирис on 04.01.2021.
//  Copyright © 2021 Алена Чимирис. All rights reserved.
//

import UIKit

class InfoViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(type(of: self), #function)
    }
    
    
    @IBOutlet var lebelView: UILabel!
    
    
    @IBOutlet var textView: UITextView!
    
//    Привычка за 21 день 
//
//    Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:
//
//    Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.
//
//    Выдержать 2 дня в прежнем состоянии самоконтроля.
//
//    Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться.
//
//    Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.
//
//    Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.
//
//    На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.
//
//    Источник: psychbook.ru
    
}