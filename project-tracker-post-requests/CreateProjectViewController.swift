//
//  CreateProjectViewController.swift
//  project-tracker-post-requests
//
//  Created by David Rifkin on 9/12/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class CreateProjectViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var createButton: UIButton!
    
    //MARK: IBAction
    @IBAction func createButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
