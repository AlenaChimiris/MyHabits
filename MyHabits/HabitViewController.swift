//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Алена Чимирис on 06.01.2021.
//  Copyright © 2021 Алена Чимирис. All rights reserved.
//

import UIKit

class HabitViewController: UIViewController, UICollectionViewDelegate   {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let datePicker = UIDatePicker()
        
        //тут попыталась сделать обновление даты, но не вышло
        datePicker.addTarget(self, action: #selector(timePicker), for: .valueChanged)
    }

    let store: HabitsStore = .shared
    
    @IBOutlet var nameHabit: UILabel! 
    
    @IBOutlet var textName: UITextField!{
        didSet {
            textName.attributedPlaceholder = NSAttributedString(string: "Бегать по утрам, спать 8 часов и т.п.")
            textName.textColor = .black
        }
    }
    
    
    @IBOutlet var nameColor: UILabel!
    
    
    @IBAction func showColorPicker(_ sender: Any) {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
        
//    @IBOutlet var colorHabit: UIColorPickerViewController! {
//        didSet {
//            let picker = UIColorPickerViewController()
//            picker.delegate = self
//            self.present(picker, animated: true, completion: nil)
//        }
//    }
    
    @IBOutlet var timeName: UILabel!
    
    
    @IBOutlet var timerHabit: UILabel! {
        didSet {
            timerHabit.text = "Каждый день в " + formatter.string(from: datePicker.date)
            
//            timerHabit.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    let datePicker = UIDatePicker()
    
    var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeStyle = .short
      return formatter
    }()
    
    @IBAction func timePicker(_ sender: Any) {
        
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButton(_ sender: Any) {
        let newHabit = Habit(name:String(),
                             date: Date(),
                        color: UIColor())
        let store = HabitsStore.shared
        store.habits.append(newHabit)
        print(store.habits)
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
//    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
//        self.dismiss(animated: true, completion: nil)
//    }
    
}
