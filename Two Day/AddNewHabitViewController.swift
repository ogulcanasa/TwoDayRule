//
//  AddNewHabitViewController.swift
//  Two Day
//
//  Created by Oğulcan Aşa on 27.12.2022.
//

import UIKit
import CoreData

class AddNewHabitViewController: UIViewController {

    var titleHabit: String?
    var reasonHabit: String?
    let date = Date()
    let calendar = Calendar.current
    var timeArray = [String]()

    @IBOutlet var addButton: UIButton!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var reasonTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.isEnabled = false
        titleTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        reasonTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        if (textField.text != "") && (reasonTextField.text != "") {
            addButton.isEnabled = true
        }
    }

    @IBAction func addButtonClicked(_ sender: Any) {

        // Takes current time
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        let time = dateFormatter.string(from: Date())
        let time2 = "01.01.2023"
        let time3 = "02.01.2023"
        timeArray = [time, time2, time3]

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let habits = NSEntityDescription.insertNewObject(forEntityName: "Habits", into: context)

            // Attributes
            if (titleTextField.text != "") && (reasonTextField.text != "") {
                habits.setValue(titleTextField.text!, forKey: "title")
                habits.setValue(reasonTextField.text!, forKey: "reason")
                habits.setValue(timeArray, forKey: "dateArray")
                habits.setValue(UUID(), forKey: "id")
            }
            do {
                try context.save()
                print("success")
            } catch {
                print("error")
            }
        } else {}
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
    }
    @IBAction func cancelButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
