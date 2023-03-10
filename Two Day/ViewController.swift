//
//  ViewController.swift
//  Two Day
//
//  Created by Oğulcan Aşa on 27.12.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var addButton: UIButton!
    @IBOutlet var tableView: UITableView!

    var habitsArray = [String]()
    var reasonsArray = [String]()
    var datesArray = [[String]]()
    var idArray = [UUID]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        title = "Two Day Rule"

        navigationController?.navigationBar.prefersLargeTitles = true

        addButton.layer.cornerRadius = 0.5 * addButton.bounds.size.width
        addButton.clipsToBounds = true
        addButton.backgroundColor = UIColor.red

        tableView.separatorStyle = .none // Remove UITableView separator

        getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData),
                                               name: NSNotification.Name(rawValue: "newData"), object: nil)
    }

    @IBAction func addButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "addSegue", sender: nil)
    }

    @objc func getData() {

        habitsArray.removeAll(keepingCapacity: false)
        reasonsArray.removeAll(keepingCapacity: false)
        datesArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext

            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Habits")
            fetchRequest.returnsObjectsAsFaults = false
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    if let results = results as? [NSManagedObject] {
                        for result in results {
                            if let title = result.value(forKey: "title") as? String {
                                self.habitsArray.append(title)
                            }
                            if let reason = result.value(forKey: "reason") as? String {
                                self.reasonsArray.append(reason)
                            }
                            if let dates = result.value(forKey: "dateArray") as? [String] {
                                self.datesArray.append(dates)
                                print(dates)
                            }
                            if let id = result.value(forKey: "id") as? UUID {
                                self.idArray.append(id)
                            }
                            self.tableView.reloadData()
                        }
                    } else {}
                }
            } catch {
                print("error")
            }
        } else {}
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habitsArray.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as? CustomTableViewCell {
            cell.titleLabel.text = habitsArray[indexPath.row]
            cell.reasonLabel.text = reasonsArray[indexPath.row]
            cell.backgroundColor = UIColor.white
            return cell
        } else {}
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "calendarSegue", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "calendarSegue" {
            if let calendarVC = segue.destination as? CalendarViewController {
                let indexPath = self.tableView.indexPathForSelectedRow
                calendarVC.habitName = habitsArray[indexPath!.row] // indexpath ******
                calendarVC.habitStreak = 2
            }
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                let context = appDelegate.persistentContainer.viewContext

                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Habits")
                let habitString = habitsArray[indexPath.row]
                fetchRequest.predicate = NSPredicate(format: "title = %@", habitString)
                fetchRequest.returnsObjectsAsFaults = false

                do {
                    let results = try context.fetch(fetchRequest)
                    if results.count > 0 {
                        if let results = results as? [NSManagedObject] {
                            for result in results {
                                if let title = result.value(forKey: "title") as? String {
                                    if title == habitsArray[indexPath.row] {
                                        context.delete(result)
                                        habitsArray.remove(at: indexPath.row)
                                        reasonsArray.remove(at: indexPath.row)
                                        datesArray.remove(at: indexPath.row)
                                        self.tableView.reloadData()

                                        do {
                                            try context.save()
                                        } catch {
                                            print("error")
                                        }
                                        break
                                    }
                                }
                            }
                        }
                    }
                } catch {
                    print("error")
                }
            } else {}
        }
    }
}
