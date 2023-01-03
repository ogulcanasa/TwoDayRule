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
        createCalendar()
    }

    func createCalendar() {

        let calendarView = UICalendarView()
        let gregorianCalendar = Calendar(identifier: .gregorian)
        calendarView.calendar = gregorianCalendar

        calendarView.locale = Locale(identifier: "zh_TW")

        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.calendar = .current
        calendarView.locale = .current
        calendarView.fontDesign = .rounded
        calendarView.delegate = self
        calendarView.layer.cornerRadius = 12
        calendarView.layer.borderWidth = 1
        calendarView.layer.borderColor = UIColor.lightGray.cgColor
        calendarView.backgroundColor = .systemBackground

        view.addSubview(calendarView)

        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendarView.topAnchor.constraint(equalTo: streakLabel.bottomAnchor, constant: 20),
            calendarView.heightAnchor.constraint(equalToConstant: 425)
        ])

        let selection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selection
    }
}

extension CalendarViewController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView,
                      decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {

    guard let day = dateComponents.day else {
        return nil
    }

    guard let month = dateComponents.month else {
        return nil
    }

    guard let year = dateComponents.year else {
        return nil
    }

        if day == 1 && month == 1 && year == 2023 {
        return UICalendarView.Decoration.default(color: .systemRed, size: .large)
    }
    return nil
    }
}

extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        print(dateComponents!)
    }
}
