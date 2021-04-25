//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Алёна Чимирис on 11.04.2021.
//  Copyright © 2021 Алена Чимирис. All rights reserved.
//


import UIKit


class HabitsViewController: UIViewController, UICollectionViewDelegate  {
    
    let store: HabitsStore = .shared
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        setupCollectionView()
        setupLayout()
//        collectionView.alwaysBounceVertical = true
//        collectionView.contentInset = .init(top: 22, left: 16, bottom: 22, right: 16)
//        self.collectionView.backgroundColor = 
        self.navigationItem.hidesBackButton = true

        
    }
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProgressCollectionViewCell.self))
        collectionView.register(HabitsCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HabitsCollectionViewCell.self))
        
        collectionView.backgroundColor = .lightGray
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    

    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    
//    let habitCollectionViewCell = HabitCollectionViewCell()
//    let progressCollectionViewCell = ProgressCollectionViewCell()
    
    private let cellID = "cellID"
    
    private func setupCollectionView() {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        collectionView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.isHidden = store.habits.isEmpty
//        collectionView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        scrollView.frame = CGRect(x: 0, y: 150, width: view.bounds.width, height: view.bounds.height)
        contentView.frame = CGRect(x: 0, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)

//        scrollView.contentSize = contentView 
        
    }
    
//    @IBAction func addButton(_ newHabit: Any) {
//        let newHabit = Habit(name: "Выпить стакан воды перед завтраком",
//                             date: Date(),
//                             color: .green)
//        let store = HabitsStore.shared
//        store.habits.append(newHabit)
//        print("store.habits")
//        dismiss(animated: true, completion: nil)
//    }
    

    private func setupLayout() {
//        view.addSubview(scrollView)
//        view.addSubview(contentView)
        view.addSubview(collectionView)

        
        
        let constains = [
        
//            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor,constant: 150),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ]
        
        NSLayoutConstraint.activate(constains)
    }
    
}

extension HabitsViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return  store.habits.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
                let progressCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath) as! ProgressCollectionViewCell

        progressCell.contentView.backgroundColor = .white
        progressCell.contentView.layer.cornerRadius = 4
    
            return progressCell
        }
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitsCollectionViewCell.self), for: indexPath) as! HabitsCollectionViewCell
        let habit = store.habits[indexPath.row]
        
        cell.nameLabel.text = habit.name
        cell.nameLabel.textColor = habit.color
        cell.timeLabel.text = habit.dateString
        cell.timeLabel.textColor = .gray

        cell.contentView.backgroundColor = .white
//        cell.heightAnchor.constraint(equalToConstant: 140)
        cell.contentView.layer.cornerRadius = 8
        
        return cell
       
    }
}


extension HabitViewController: UICollectionViewDelegateFlowLayout{
    
        private var baseInsets: CGFloat {return 5}

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
        let height: CGFloat = indexPath.row == 0 ? 60 : 140

        return   CGSize(width: width, height: height)
    }
}

//        let width: CGFloat = (collectionView.frame.size.width - baseInsets*5)

//        return CGSize(width: 140, height: baseInsets)
//    }
//
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//            return UIEdgeInsets(top: baseInsets, left: baseInsets, bottom: baseInsets, right: baseInsets)
//        }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//
//        return baseInsets
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//
//        return baseInsets
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//
//        return CGSize(width: 140, height: baseInsets)
//    }
//
//}
