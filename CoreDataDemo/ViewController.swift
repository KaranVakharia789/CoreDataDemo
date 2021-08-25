//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Karan Vakharia on 16/07/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtNumber: UITextField!

    @IBOutlet weak var txtCollage: UITextField!
    @IBOutlet weak var txtDepartment: UITextField!
    @IBOutlet weak var tblView: UITableView!
    
    var arrStudent = [Student]()
    let refreshControl = UIRefreshControl()
    var isUpdate = false
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tblView.register(UINib(nibName: "StudentCell", bundle: nil), forCellReuseIdentifier: "StudentCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        arrStudent = DataManager.sharedManager.getStudent()
        self.tblView.reloadData()
    }
    
    @IBAction func btnSaveClicled(_ sender: Any) {
        saveData()
        txtName.text = ""
        txtNumber.text = ""
        txtCollage.text = ""
        txtDepartment.text = ""
    }
    
    func saveData() {
//        if validation code here......
        let param = ["name":txtName.text, "number":txtNumber.text, "collage":txtCollage.text, "department":txtDepartment.text]
        DispatchQueue.global(qos: .default).async { [self] in
            if isUpdate == true{
                print(arrStudent[index])
                DataManager.sharedManager.editStudent(object: param as! [String : String], index: index)
            } else {
                DataManager.sharedManager.save(object: param as NSDictionary)
            }
            
            DispatchQueue.main.async {
                self.viewWillAppear(true)
                isUpdate = false
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrStudent.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath) as! StudentCell
        cell.student = arrStudent[indexPath.row]
        return cell
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        txtName.text = arrStudent[indexPath.row].name
        txtNumber.text = arrStudent[indexPath.row].number
        txtCollage.text = arrStudent[indexPath.row].collage
        txtDepartment.text = arrStudent[indexPath.row].department
        index = indexPath.row
        isUpdate = true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrStudent = DataManager.sharedManager.deleteStudent(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}
