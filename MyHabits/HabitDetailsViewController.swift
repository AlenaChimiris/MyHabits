//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Алена Чимирис on 09.01.2021.
//  Copyright © 2021 Алена Чимирис. All rights reserved.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    let habit: Habit
    init(habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cellID = "cellID"
    
    var activeLabel: UILabel = {
        let activeLabel = UILabel()
        activeLabel.textColor = .lightGray
        activeLabel.text = "Активность"
        activeLabel.font = UIFont.systemFont(ofSize: 16)
        activeLabel.translatesAutoresizingMaskIntoConstraints = false
        return activeLabel
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        return tableView
    }()
    
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @objc func tapCorrect() {
        
        //переход на экран редактирования привычки
        let correctHabitVC = HabitViewController(habit: habit, correctVC: true)
        correctHabitVC.modalPresentationStyle = .formSheet
        present(correctHabitVC, animated: false, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupLayout()
        title = habit.name
        
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .purple
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(tapCorrect))
        navigationItem.rightBarButtonItem?.tintColor = .purple
        navigationItem.backBarButtonItem?.tintColor = .purple
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemGray6
        tableView.register(HabitDetailsTableCell.self, forCellReuseIdentifier: cellID)
    }
    
    
    private func setupLayout() {
        tableView.addSubview(activeLabel)
        view.addSubview(tableView)
        
        view.backgroundColor = .white
        
        let constraints = [
            
            activeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 12),
            activeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            activeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension HabitDetailsViewController: UITableViewDelegate {
    
}

extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: HabitDetailsTableCell = tableView.dequeueReusableCell(withIdentifier: cellID) as! HabitDetailsTableCell
        let dates = HabitsStore.shared.dates
        cell.textLabel?.text = HabitsStore.shared.trackDateString(forIndex: dates.count - 1 - indexPath.item)
        
        if HabitsStore.shared.habit(habit, isTrackedIn: dates[dates.count - 1 - indexPath.item]) == true {
            cell.doneHabitMark.isHidden = false
        } else {
            cell.doneHabitMark.isHidden = true
        }
        
        return cell
    }
    
}
