//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Алёна Чимирис on 11.04.2021.
//  Copyright © 2021 Алена Чимирис. All rights reserved.
//


import UIKit


class HabitsViewController: UIViewController, UICollectionViewDelegate, UINavigationControllerDelegate  {
    
    
    var detailsVC: HabitDetailsViewController?
    
    let habitID = "habitID"
    let progressID = "progressID"
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: progressID)
        collectionView.register(HabitsCollectionViewCell.self, forCellWithReuseIdentifier: habitID)
        collectionView.backgroundColor = .systemGray6
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    private func setupCollectionView() {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        collectionView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
        collectionView.reloadInputViews()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        scrollView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        contentView.frame = CGRect(x: 0, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
        
        collectionView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupLayout()
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = .init(top: 22, left: 16, bottom: 22, right: 16)
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showHabitVC))
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.title = "Сегодня"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.delegate = self
        
    }
    
    private func setupLayout() {
        view.addSubview(collectionView)
        
        let constains = [
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ]
        
        NSLayoutConstraint.activate(constains)
    }
    
    @objc func showHabitVC() {
        
        let habitVC = HabitViewController(habit: Habit(name: "", date: Date(), color: .orange), correctVC: false)
        self.navigationController?.present(habitVC, animated: true)
        
    }
    
    
}

extension HabitsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return HabitsStore.shared.habits.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: habitID, for: indexPath) as! HabitsCollectionViewCell
        if indexPath.section == 1 {
            
            let habit = HabitsStore.shared.habits[indexPath.item]
            
            cell.habit = habit
            cell.habitTappedCompletion = {
                HabitsStore.shared.track(habit)
            }
        
            cell.nameLabel.text = habit.name
            cell.nameLabel.textColor = habit.color
            cell.timeLabel.text = habit.dateString
            cell.timeLabel.textColor = .gray
            cell.colorView.backgroundColor = habit.color
            cell.countLabel.text = "Подряд:\(habit.trackDates.count)"
            
            return cell
        }
        
        let progressCell = collectionView.dequeueReusableCell(withReuseIdentifier: progressID, for: indexPath) as! ProgressCollectionViewCell
        if indexPath.section == 0 {
            let progress = HabitsStore.shared.todayProgress
            progressCell.progress = progress
            
            return progressCell
        }        
        return cell
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
        let height: CGFloat = indexPath.section == 0 ? 60 : 130
        
        return   CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 22, left: 16, bottom: 0, right: 16)
        } else  {
            return UIEdgeInsets(top: 18, left: 16, bottom: 12, right: 16)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function, "сработала")
        if indexPath.section == 1 {
            let habit = HabitsStore.shared.habits[indexPath.item]
            detailsVC = HabitDetailsViewController(habit: habit)
            self.navigationController?.pushViewController(detailsVC!, animated: true)
            self.dismiss(animated: true, completion: nil)
            print("detailsVC")
            
        }
        
        if navigationController == nil {
            print ("nil")
        }
    }
}


