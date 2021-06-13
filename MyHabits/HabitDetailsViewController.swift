//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Алена Чимирис on 09.01.2021.
//  Copyright © 2021 Алена Чимирис. All rights reserved.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    private lazy var correctHabitVC = CorrectHabitViewController(habit: habit)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupLayout()
        title = "Править"
        
        navigationItem.largeTitleDisplayMode = .never
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(tapCorrect))
        navigationItem.rightBarButtonItem?.tintColor = .purple
        navigationItem.backBarButtonItem?.tintColor = .purple
    }
    
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
        activeLabel.font = UIFont.systemFont(ofSize: 12)
        activeLabel.translatesAutoresizingMaskIntoConstraints = false
        return activeLabel
    }()
    
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        return tableView
    }()
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemGray6
        tableView.register(HabitDetailsTableCell.self, forCellReuseIdentifier: cellID)
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        view.addSubview(activeLabel)
        
        view.backgroundColor = .white
        
        let constraints = [
            
            activeLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 50),
            activeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: activeLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    @objc func tapCorrect() {
        //переход на экран редактирования привычки
        navigationController?.present(correctHabitVC, animated: true, completion: nil)
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
        
        cell.textLabel?.text = HabitsStore.shared.trackDateString(forIndex: HabitsStore.shared.dates.count - 1 - indexPath.item)
        
        if HabitsStore.shared.habit(habit, isTrackedIn: HabitsStore.shared.dates[HabitsStore.shared.dates.count - 1 - indexPath.item]) == true {
            cell.doneHabitMark.isHidden = false
        }
        
        return cell
    }
    
}
