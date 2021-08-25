//
//  DataManager.swift
//  CoreDataDemo
//
//  Created by Karan Vakharia on 16/07/21.
//

import Foundation
import CoreData

class DataManager {
    static let sharedManager = DataManager()
    let context = PersistentContainer.shared.context
//    func createStudent() {
//        let student = Student(context: PersistentContainer.shared.context)
//        PersistentContainer.shared.saveContext()
//    }
//
//    func fetchStudent() {
//        do {
//            guard let result = try PersistentContainer.shared.context.fetch(Student.fetchRequest()) as? [Student] else {return}
//
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
    func save(object: NSDictionary) {
        let studentEntity = NSEntityDescription.insertNewObject(forEntityName: "Student", into: context) as! Student
        studentEntity.name = object["name"] as? String
        studentEntity.number = object["number"] as? String
        studentEntity.collage = object["collage"] as? String
        studentEntity.department = object["department"] as? String
        do {
            try context.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func getStudent() -> [Student] {
        var student = [Student]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Student")
        do {
            student = try context.fetch(fetchRequest) as! [Student]
        } catch let error {
            print(error.localizedDescription)
        }
        return student
    }
    
    func deleteStudent(index:Int) -> [Student] {
        var student = getStudent()
        context.delete(student[index])
        student.remove(at: index)
        do {
            try context.save()
        } catch  {
            print("Do not Delete form data")
        }
        return student
    }
    
    func editStudent(object: [String:String], index: Int) {
        let student = getStudent()
        student[index].name = object["name"]
        student[index].department = object["department"]
        student[index].collage = object["collage"]
        student[index].number = object["number"]
        do {
            try context.save()
        } catch  {
            print("Do not Edit form data")
        }
    }
}
