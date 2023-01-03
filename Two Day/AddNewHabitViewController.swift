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
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let habits = NSEntityDescription.insertNewObject(forEntityName: "Habits", into: context)

            // Attributes
            if (titleTextField.text != "") && (reasonTextField.text != "") {
                habits.setValue(titleTextField.text!, forKey: "title")
                habits.setValue(reasonTextField.text!, forKey: "reason")
            }
            do {
                try context.save()
                print("success")
            } catch {
                print("error")
            }
        } else {}
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
