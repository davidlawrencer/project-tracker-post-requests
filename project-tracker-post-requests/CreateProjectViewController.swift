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
        
        guard let project = createProjectFromFields() else {
            //TODO: error... maybe a pop-up
            return
        }
        
        ProjectAPIClient.manager.postProject(project: project) { (result) in
            switch result {
            case .success(let success):
            self.navigationController?.popViewController(animated: true)
                //we could do something with the data
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Private
    private func createProjectFromFields() -> Project? {
        guard let name = nameTextField.text else {
            return nil
        }
        return Project(name: name, dueDate: formatAirTableDate(date: datePicker.date) )
    }
    
    private func formatAirTableDate(date: Date) -> String {
        return date.description.components(separatedBy: .whitespaces)[0]
    }
}
