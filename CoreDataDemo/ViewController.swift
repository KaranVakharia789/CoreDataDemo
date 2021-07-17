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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tblView.register(UINib(nibName: "StudentCell", bundle: nil), forCellReuseIdentifier: "StudentCell")
        arrStudent = DataManager.sharedManager.getStudent()
        
    }
    @IBAction func btnSaveClicled(_ sender: Any) {
        saveData()
    }
    
    func saveData() {
        let param = ["name":txtName.text, "number":txtNumber.text, "collage":txtCollage.text, "department":txtDepartment.text]
        DataManager.sharedManager.save(object: param as NSDictionary)
//        tblView.reloadData()
        DispatchQueue.main.async{
            let vc = self
            vc.tblView.reloadData()
            
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
        print(indexPath.row)
    }
}
