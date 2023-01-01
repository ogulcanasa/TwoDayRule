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
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var reasonTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: nil, action: #selector(addHabit))
        navigationItem.rightBarButtonItem?.isEnabled = false
        titleTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        reasonTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (textField.text != "") && (reasonTextField.text != "") {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    @objc func addHabit() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let habits = NSEntityDescription.insertNewObject(forEntityName: "Habits", into: context)
            
            //Attributes
            
        habits.setValue(titleTextField.text!, forKey: "title")
        habits.setValue(reasonTextField.text!, forKey: "reason")
        
        do {
            try context.save()
            print("success")
        } catch {
            print("error")
        }
        
        performSegue(withIdentifier: "backSegue", sender: nil)
    }
}
