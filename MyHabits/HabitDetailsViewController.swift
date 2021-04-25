//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Алена Чимирис on 09.01.2021.
//  Copyright © 2021 Алена Чимирис. All rights reserved.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBOutlet var active: UILabel!
    
    
    @IBOutlet var tableView: UITableView!
        

    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
}
