//
//  EditingViewController.swift
//  2016120081
//
//  Created by SWUCOMPUTER on 2018. 5. 16..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class EditingViewController: UIViewController, UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var categoryPicker: UIPickerView!
    @IBOutlet var category: UITextField!
    @IBOutlet var shopname: UITextField!
    @IBOutlet var distance: UITextField!
    @IBOutlet var review: UITextView!
    
    @IBOutlet var buttonHart1: UIButton!
    @IBOutlet var buttonHart2: UIButton!
    @IBOutlet var buttonHart3: UIButton!
    @IBOutlet var buttonHart4: UIButton!
    @IBOutlet var buttonHart5: UIButton!
    
    var categoryArray: [String] = ["FOOD", "Healthy", "PLAY", "Shopping"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        category.isHidden = true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if textField == self.shopname {
            textField.resignFirstResponder()
            self.distance.becomeFirstResponder()
        }
        else if textField == self.distance {
            textField.resignFirstResponder()
            self.review.becomeFirstResponder()
        }
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
        return categoryArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryArray[row]
    }
    @IBAction func getValue() {
        let cate: String = categoryArray[self.categoryPicker.selectedRow(inComponent: 0)]
        category.text = cate
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
        
        object.setValue(shopname.text, forKey: "shopName")
        object.setValue(distance.text, forKey: "distance")
        object.setValue(category.text, forKey: "category")
        
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
            
        }
        self.navigationController?.popViewController(animated: true)
    }
}
