//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Алена Чимирис on 06.01.2021.
//  Copyright © 2021 Алена Чимирис. All rights reserved.
//

import UIKit


class HabitViewController: UIViewController, UICollectionViewDelegate   {
    
    
    var delegate: CollectionDelegate?
    
    let datePicker = UIDatePicker()
    
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
        viewColorPicker.layer.cornerRadius = 30/2
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
    
    var delButtonHabit: UIButton = {
        let dBh = UIButton()
        dBh.translatesAutoresizingMaskIntoConstraints = false
        dBh.setTitle("Удалить привычку", for: .normal)
        dBh.setTitleColor(.red, for: .normal)
        dBh.addTarget(self, action: #selector(showAlert(_:)), for: .touchUpInside)
        return dBh
    }()
    
    //код для Detail по кнопке "Править"
    public var habit: Habit
    public var correctVC: Bool
    
    init(habit: Habit, correctVC: Bool) {
        self.habit = habit
        self.correctVC = correctVC
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc func showColorPicker(_ sender: Any) {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let _ = viewController.selectedColor
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
    
    @objc func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //сохранение новой привычки
    @objc func saveHabit(sender: Any) {
        let newHabit = Habit(name: textName.text ?? "",
                             date: datePicker.date,
                             color: viewColorPicker.backgroundColor ?? .green)
        let store = HabitsStore.shared
        store.habits.append(newHabit)
        print(store.habits)
        reloadInputViews()
        
        dismiss(animated: true) { [weak self] in
            print("")
            self?.delegate?.reloadCV()
        }
    }
    
    //для correctVC
    @objc func saveHabitcorrect() {
        let newHabit = Habit(name: textName.text ?? "",
                             date: datePicker.date,
                             color: viewColorPicker.backgroundColor ?? .green)
        
        if let index = HabitsStore.shared.habits.firstIndex(where: { $0 == self.habit }) {
            HabitsStore.shared.habits[index] = newHabit
        }
       
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dateChanged() {
        datePickerValueChange()
    }
    
    @objc func tepGestureDone() {
        view.endEditing(true)
    }
    
    //удаление привычки из списка экран по кнопке "Править"
    @objc  func showAlert(_ sender: Any) {
        let alertController = UIAlertController(title: "Удалить пост?", message: "Вы х отите удалить привычку \(habit.name)?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in
            print("Отмена")
        }
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            if let deletHabit = HabitsStore.shared.habits.firstIndex(where: ({$0.name == self.habit.name})) {
                HabitsStore.shared.habits.remove(at: deletHabit)
                print("Удалить")
            }
            
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        view.addSubview(navBar)
        
        if correctVC == false {
            
            let barItem = UINavigationItem(title: "Создать")
            let saveButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveHabit))
            barItem.rightBarButtonItem = saveButtonItem
            let cancelButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(backButton))
            barItem.leftBarButtonItem = cancelButtonItem
            navBar.setItems([barItem], animated: false)
            cancelButtonItem.tintColor = .purple
            saveButtonItem.tintColor = .purple
            delButtonHabit.isHidden = true
            view.backgroundColor = .white
            
        } else {
            
            let barItem = UINavigationItem(title: "Править")
            let saveButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveHabitcorrect))
            barItem.rightBarButtonItem = saveButtonItem
            let cancelButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(backButton))
            barItem.leftBarButtonItem = cancelButtonItem
            navBar.setItems([barItem], animated: false)
            cancelButtonItem.tintColor = .purple
            saveButtonItem.tintColor = .purple
            delButtonHabit.isHidden = false
            view.backgroundColor = .white
            textTimePicker.text = formatter.string(from: habit.date)
            textName.textColor = .blue
            
        }
        
        textName.text = habit.name
        textName.textColor = habit.color
        viewColorPicker.backgroundColor = habit.color
        setupLayout()
        
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        datePicker.datePickerMode = .countDownTimer
        datePicker.backgroundColor = .white
        textTimePicker.inputView = datePicker
        
        let tap = UITapGestureRecognizer(target:self, action: #selector(showColorPicker))
        viewColorPicker.addGestureRecognizer(tap)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tepGestureDone))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    private func setupLayout() {
        view.addSubview(nameHabit)
        view.addSubview(textName)
        view.addSubview(nameColor)
        view.addSubview(viewColorPicker)
        view.addSubview(timeName)
        view.addSubview(timerHabit)
        view.addSubview(textTimePicker)
        view.addSubview(delButtonHabit)
        
        let constains = [
            
            nameHabit.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
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
            viewColorPicker.widthAnchor.constraint(equalToConstant: 30),
            viewColorPicker.heightAnchor.constraint(equalToConstant: 30),
            
            timeName.topAnchor.constraint(equalTo: viewColorPicker.bottomAnchor, constant: 7),
            timeName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timeName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            timerHabit.topAnchor.constraint(equalTo: timeName.bottomAnchor, constant: 20),
            timerHabit.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            textTimePicker.topAnchor.constraint(equalTo: timerHabit.topAnchor),
            textTimePicker.leadingAnchor.constraint(equalTo: timerHabit.trailingAnchor, constant: 3),
            
            delButtonHabit.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            delButtonHabit.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)            
        ]
        
        NSLayoutConstraint.activate(constains)
        
        textName.becomeFirstResponder()
    }    
    
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
}

extension HabitViewController: UIGestureRecognizerDelegate {
    
}
