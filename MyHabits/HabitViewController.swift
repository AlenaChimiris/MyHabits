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
    
    @IBOutlet weak var viewColorPicker: UIView! {
        didSet {
            viewColorPicker.backgroundColor = .orange
        }
    }
    
    @IBAction func showColorPicker(_ sender: Any) {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        viewColorPicker.backgroundColor = color
    }
    
    var datePicker = UIDatePicker()
    
    @IBOutlet var timeName: UILabel!

    @IBOutlet var timerHabit: UILabel! {
        didSet {
            timerHabit.text = "Каждый день в "  + formatter.string(from: datePicker.date)
//            timerHabit.inputView = datePicker
        }
    }
  
    var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = .none
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
      return formatter
    }()
    
    @IBAction func timePicker() {
//        self.timerHabit.text = "Каждый день в " + formatter.string(from: datePicker.date)
        datePicker.addTarget(self, action: #selector(datePickerValueChange), for: .valueChanged)
    }
    
    //тут попыталась сделать обновление времени
    @objc func datePickerValueChange(picker: UIDatePicker) {
        timerHabit.text = formatter.string(from: picker.date)
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //сохранение привычки
    @IBAction func addButton(_ sender: Any) {
        let habit = HabitViewController()
        let newHabit = Habit(name:String(),
                             date: Date(),
                        color: UIColor())
        habit.textName.text = newHabit.name
        habit.nameColor.backgroundColor = newHabit.color
        habit.datePicker.date = newHabit.date
        let store = HabitsStore.shared
        store.habits.append(newHabit)
        print(store.habits)
        dismiss(animated: true, completion: nil)
    }
    
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
}
