//
//  CreateFriendViewController.swift
//  CoreDataExample
//
//  Created by M1 on 09.09.2022.
//

import UIKit

class CreateFriendViewController: UIViewController {

    @IBOutlet var nameInputField: UITextField!
    @IBOutlet var birthDayPicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameInputField.delegate = self
    }
    
    @IBAction private func savePressed(_ sender: Any) {
        guard let name = nameInputField.text, !name.isEmpty else {
            showError()
            return
        }
        let context = CoreDataManager.instance.persistentContainer.viewContext
        let newPerson = Person(context: context)
        newPerson.name = name
        newPerson.birthDate = birthDayPicker.date
        CoreDataManager.instance.saveContext()
        
        // TODO: need to create new field
        navigationController?.popViewController(animated: true)
    }
    
    private func showError() {
        let alertVC = UIAlertController(title: "Error", message: "Name should be filled", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}

extension CreateFriendViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
