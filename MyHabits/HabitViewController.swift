//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Алена Чимирис on 06.01.2021.
//  Copyright © 2021 Алена Чимирис. All rights reserved.
//

import UIKit


class HabitViewController: UIViewController, UICollectionViewDelegate   {
    
    
    let datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        datePicker.datePickerMode = .countDownTimer
        datePicker.backgroundColor = .white
        textTimePicker.inputView = datePicker
        
        let tap = UITapGestureRecognizer(target:self, action: #selector(showColorPicker))
        viewColorPicker.addGestureRecognizer(tap)
        
        setupLayout()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tepGestureDone))
        self.view.addGestureRecognizer(tapGesture)
        
        
    }
    
    
    var nameHabit: UILabel = {
        let nameHabit = UILabel()
        nameHabit.text = "Название"
        nameHabit.textColor = .black
        nameHabit.font = UIFont.systemFont(ofSize: 18)
        nameHabit.translatesAutoresizingMaskIntoConstraints = false
        return nameHabit
    }()
    
    var textName: UITextField = {
        let textName = UITextField()
        textName.textColor = .black
        textName.attributedPlaceholder = NSAttributedString(string: "Бегать по утрам, спать 8 часов и т.п.")
        textName.font = UIFont.systemFont(ofSize: 16)
        textName.translatesAutoresizingMaskIntoConstraints = false
        return textName
    }()
    
    var nameColor: UILabel = {
        let nameColor = UILabel()
        nameColor.text = "Цвет"
        nameColor.textColor = .black
        nameColor.font = UIFont.systemFont(ofSize: 18)
        nameColor.translatesAutoresizingMaskIntoConstraints = false
        return nameColor
    }()
    
    var viewColorPicker: UIView = {
        let viewColorPicker = UIView()
        viewColorPicker.layer.backgroundColor = UIColor.orange.cgColor
        viewColorPicker.clipsToBounds = true
        viewColorPicker.layer.cornerRadius = 40/2
        viewColorPicker.translatesAutoresizingMaskIntoConstraints = false
        return viewColorPicker
    }()
    
    var timeName: UILabel = {
        let timeName = UILabel()
        timeName.text = "Время"
        timeName.textColor = .black
        timeName.font = UIFont.systemFont(ofSize: 18)
        timeName.translatesAutoresizingMaskIntoConstraints = false
        return timeName
    }()
    
    var timerHabit: UILabel = {
        let timerHabit = UILabel()
        timerHabit.text = "Каждый день в"
        timerHabit.textColor = .black
        timerHabit.font = UIFont.systemFont(ofSize: 16)
        timerHabit.translatesAutoresizingMaskIntoConstraints = false
        return timerHabit
    }()
    
    var textTimePicker: UITextField = {
        let textTimePicker = UITextField()
        textTimePicker.text = "11:00 AM"
        textTimePicker.textColor = .blue
        textTimePicker.font = UIFont.systemFont(ofSize: 16)
        textTimePicker.translatesAutoresizingMaskIntoConstraints = false
        return textTimePicker
    }()
    
    private func setupLayout() {
        view.addSubview(nameHabit)
        view.addSubview(textName)
        view.addSubview(nameColor)
        view.addSubview(viewColorPicker)
        view.addSubview(timeName)
        view.addSubview(timerHabit)
        view.addSubview(textTimePicker)
        
        let constains = [
            
            nameHabit.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            nameHabit.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameHabit.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            textName.topAnchor.constraint(equalTo: nameHabit.bottomAnchor, constant: 20),
            textName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            nameColor.topAnchor.constraint(equalTo: textName.bottomAnchor, constant: 20),
            nameColor.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameColor.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            viewColorPicker.topAnchor.constraint(equalTo: nameColor.bottomAnchor, constant: 20),
            viewColorPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            viewColorPicker.widthAnchor.constraint(equalToConstant: 40),
            viewColorPicker.heightAnchor.constraint(equalToConstant: 40),
            
            timeName.topAnchor.constraint(equalTo: viewColorPicker.bottomAnchor, constant: 7),
            timeName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timeName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            timerHabit.topAnchor.constraint(equalTo: timeName.bottomAnchor, constant: 20),
            timerHabit.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            
            textTimePicker.topAnchor.constraint(equalTo: timerHabit.topAnchor),
            textTimePicker.leadingAnchor.constraint(equalTo: timerHabit.trailingAnchor, constant: 3)
            
        ]
        
        NSLayoutConstraint.activate(constains)
        
        textName.becomeFirstResponder()
    }
    
    
    @objc func showColorPicker(_ sender: Any) {
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
    
    
    var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = .some("HH:mm")
        formatter.timeStyle = .short
        return formatter
    }()
    
    
    //обновление времени
    @objc func datePickerValueChange() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeStyle = .short
        textTimePicker.text = formatter.string(from: datePicker.date)
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //сохранение привычки
    @IBAction func addButton(_ sender: Any) {
        saveHabit()
    }
    
    @objc func saveHabit() {
        let habit = HabitViewController()
        let newHabit = Habit(name: textName.text ?? "",
                             date: datePicker.date,
                             color: viewColorPicker.backgroundColor ?? .green)
        habit.textName.text = newHabit.name
        habit.viewColorPicker.backgroundColor = newHabit.color
        habit.textTimePicker.text = newHabit.dateString
        let store = HabitsStore.shared
        store.habits.append(newHabit)
        print(store.habits)
        reloadInputViews()
        //        store.habits.removeAll()
        //        print(store.habits)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dateChanged() {
        datePickerValueChange()
    }
    
    @objc func tepGestureDone() {
        view.endEditing(true)
    }
    
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
}

extension HabitViewController: UIGestureRecognizerDelegate {
    
}
