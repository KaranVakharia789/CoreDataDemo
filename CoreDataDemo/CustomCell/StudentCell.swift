//
//  StudentCell.swift
//  CoreDataDemo
//
//  Created by Karan Vakharia on 16/07/21.
//

import UIKit

class StudentCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblCollage: UILabel!
    @IBOutlet weak var lblDepartment: UILabel!
    
    var student: Student! {
        didSet {
            lblName.text = student.name
            lblNumber.text = student.number
            lblCollage.text = student.collage
            lblDepartment.text = student.department
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
