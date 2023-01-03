//
//  SettingsViewController.swift
//  Two Day
//
//  Created by Oğulcan Aşa on 27.12.2022.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!

    let cellHeight: CGFloat = 40
    var versionNumber = 1
    let versionName = "Version"
    var versionBuild = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as? String
        let build = dictionary["CFBundleVersion"] as? String
        versionBuild = "\(version!).\(build!)"

        tableView.dataSource = self
        tableView.delegate = self

        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = versionName
        cell.detailTextLabel?.text = versionBuild

        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.25
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return versionNumber
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "versionSegue", sender: nil)
    }
}
