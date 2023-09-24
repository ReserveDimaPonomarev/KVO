//
//  ViewController.swift
//  KVO
//
//  Created by Дмитрий Пономарев on 02.05.2023.
//

import UIKit

class Person: NSObject {
    
    @objc dynamic var name = String()
}

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var TextField: UITextField!
    
    var nameObservation: NSKeyValueObservation?
    var textObservation: NSKeyValueObservation?

    @objc dynamic var newText = String()
    var newPerson = Person()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameObservation = newPerson.observe(\.name, options: [.new, .old]) { [weak self] object, value in
            guard let updatedValue = value.newValue else { return }
            guard let oldValue = value.oldValue else { return }
            self?.nameLabel.text = updatedValue
            print("oldvalue was \(oldValue) changed to new value \(updatedValue)")
        }
        textObservation = observe(\.newText, options: [.new, .old]) { [weak self] object, value in
            print("\(value.oldValue) was chaged to \(value.newValue)")
            self?.textLabel.text = value.newValue
        }
    }

    @IBAction func tappedButton(_ sender: Any) {
        newPerson.name = newText

    }
    
    @IBAction func tappedTextField(_ sender: Any) {
        newText = TextField.text ?? "notext"
    }
}

