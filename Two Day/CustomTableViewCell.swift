//
//  CustomTableViewCell.swift
//  Two Day
//
//  Created by Oğulcan Aşa on 28.12.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var reasonLabel: UILabel!
    @IBOutlet var isDoneButton: UIButton!
    @IBOutlet var day1Button: UIButton!
    @IBOutlet var day2Button: UIButton!
    @IBOutlet var day3Button: UIButton!
    @IBOutlet var day4Button: UIButton!
    @IBOutlet var day5Button: UIButton!
    
    var isDone = true
    var Buttons = [UIButton]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isDoneButton.imageView?.contentMode = .scaleToFill
        
        Buttons = [day1Button, day2Button, day3Button, day4Button, day5Button]

        for button in Buttons {
            button.layer.cornerRadius = 0.5 * button.bounds.size.width
            button.clipsToBounds = true
        }

        isDoneButton.layer.cornerRadius = 0.5 * isDoneButton.bounds.size.width
        isDoneButton.clipsToBounds = true
        isDoneButton.backgroundColor = UIColor.lightGray
        isDoneButton.tintColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 0.25
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }
    

    
    @IBAction func isDoneButtonClicked(_ sender: Any) {

        if isDone {
            isDoneButton.backgroundColor = .red
            day1Button.backgroundColor = .red
            isDone = false
        } else {
            isDoneButton.backgroundColor = .lightGray
            day1Button.backgroundColor = .lightGray
            isDone = true
        }
    }
 
    @IBAction func dayButtonClicked(_ sender: Any) {
    }
    
}
