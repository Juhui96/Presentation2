//
//  FirstViewController.swift
//  2016120081
//
//  Created by SWUCOMPUTER on 2018. 5. 26..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet var timeText: UITextField!
    @IBOutlet var nowText: UITextField!
    @IBOutlet var positionText: UITextField!
    @IBOutlet var segment: UISegmentedControl!
    
    var detailDate: NSManagedObject?
    var dates: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let name = appDelegate.userName {
            self.title = name + "님 안녕하세요 :)"
        }
    }
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true //delegate method (키보드 없애기)
    }
    @IBAction func buttonLogout(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginView = storyboard.instantiateViewController(withIdentifier: "LoginView")
        
        let alert = UIAlertController(title:"로그아웃 하시겠습니까?",message: "",preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            let urlString: String = "http://localhost:8888/login/logout.php"
            guard let requestURL = URL(string: urlString) else { return }
            var request = URLRequest(url: requestURL)
            request.httpMethod = "POST"
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (responseData, response, responseError) in
                guard responseError == nil else { return }
            }
            task.resume()
        self.present(loginView, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    @IBAction func inputPressed(_ sender: UIButton) {
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Dates")
        
        let entity = NSEntityDescription.entity(forEntityName: "Dates", in: context)
        let object = NSManagedObject(entity: entity!, insertInto: context)
        object.setValue(Date(), forKey: "saveDate")
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save  (error),  (error.userInfo)")
        }
        do {
            dates = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch.  (error),  (error.userInfo)") }
        self.updateViewConstraints()
        
        //self.navigationController?.popViewController(animated: true)
        if sender.isTouchInside{
        if let date = detailDate {
            let dbDate: Date? = date.value(forKey: "saveDate") as? Date
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd h:mm a"
            if let unwrapDate = dbDate {
                let displayDate = formatter.string(from: unwrapDate as Date)
                nowText.text = displayDate
            }
        }
    }
}
    @IBAction func switchSeg(_ sender: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0{
            positionText.text = "서울여자대학교 정문"
        }
        else {
            positionText.text = ""
        }
    }
}
