//
//  ViewController.swift
//  DemoRealm
//
//  Created by Khuat Van Dung on 8/31/17.
//  Copyright © 2017 Khuat Van Dung. All rights reserved.
//

import UIKit
import RealmSwift
class ViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var address: UITextField!
    let realm = try! Realm()
    var h: Human?
    var isUpdate = false
    @IBOutlet weak var saveButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let human = h {
            navigationItem.title = "Update"
            name.text = human.name
            age.text = String(human.age)
            address.text = human.address
            print(human.id)
            isUpdate = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addHuman() {
        let human = Human()
        human.name = name.text ?? ""
        human.age = Int(age.text!) ?? 0
        human.address = address.text ?? ""
        let realm = try! Realm()
        try! realm.write {
            realm.add(human)
            
        }
        
    }
    @IBAction func save(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            addHuman()
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController {
            let human = Human()
            human.id = (h?.id)!
            human.name = self.name.text ?? ""
            human.age = Int(self.age.text!) ?? 0
            human.address = self.address.text ?? ""
            try! realm.write {
                realm.add(human, update: true)
            }
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The ViewController is not inside a navigation controller.")
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The ViewController is not inside a navigation controller.")
        }
    }
    
    //    // MARK: Navigation
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        super.prepare(for: segue, sender: sender)
    //        guard let button = sender as? UIBarButtonItem, button === saveButton else {
    //            return
    //        }
    //        if isUpdate == true {
    //            h = Human()
    //            h?.name = self.name.text ?? ""
    //            h?.age = Int(self.age.text!) ?? 0
    //            h?.address = self.address.text ?? ""
    //        } else {
    //
    //        }
    //    }
}

