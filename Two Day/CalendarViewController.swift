//
//  CalendarViewController.swift
//  Two Day
//
//  Created by Oğulcan Aşa on 27.12.2022.
//

import UIKit

class CalendarViewController: UIViewController {
    
    @IBOutlet var habitLabel: UILabel!
    @IBOutlet var streakLabel: UILabel!
    
    var habitName: String = ""
    var habitStreak: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        habitLabel.text = habitName
        streakLabel.text = "Streak \(habitStreak) days"
    }
}
