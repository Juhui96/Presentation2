//
//  AutomaticViewController.swift
//  2016120081
//
//  Created by SWUCOMPUTER on 2018. 5. 29..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class AutomaticViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var categoryPicker2: UIPickerView!
    @IBOutlet var category2: UITextField!
    @IBOutlet var shopname2: UITextField!
    @IBOutlet var distance2: UITextField!
    @IBOutlet var distance3: UITextField!
    @IBOutlet var review2: UITextView!
 
    @IBOutlet var buttonHart1: UIButton!
    @IBOutlet var buttonHart2: UIButton!
    @IBOutlet var buttonHart3: UIButton!
    @IBOutlet var buttonHart4: UIButton!
    @IBOutlet var buttonHart5: UIButton!
    
    var categoryArray2: [String] = ["FOOD", "Healthy", "PLAY", "Shopping"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        shopname2.text = "스와레"
        distance2.text = "서울 노원구 화랑로51길 20"
        distance3.text = "걸어서 15분거리"
        category2.text = "FOOD"
        
        distance3.isHidden = true
        category2.isHidden = true

        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryArray2.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryArray2[row]
    }
    @IBAction func change1(_ sender: UIButton) {
        if sender.isTouchInside{
            buttonHart1.isHidden = true
        }
    }
    @IBAction func change2(_ sender: UIButton) {
        if sender.isTouchInside{
            buttonHart2.isHidden = true
        }
    }
    @IBAction func change3(_ sender: UIButton) {
        if sender.isTouchInside{
            buttonHart3.isHidden = true
        }
    }
    @IBAction func change4(_ sender: UIButton) {
        if sender.isTouchInside{
            buttonHart4.isHidden = true
        }
    }
    @IBAction func change5(_ sender: UIButton) {
        if sender.isTouchInside{
            buttonHart5.isHidden = true
        }
    }
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Lists", in: context)
        let object = NSManagedObject(entity: entity!, insertInto: context)
        
        object.setValue(shopname2.text, forKey: "shopName")
        object.setValue(distance3.text, forKey: "distance")
        object.setValue(category2.text, forKey: "category")
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
            
        }
        self.navigationController?.popViewController(animated: true)
    }
}

