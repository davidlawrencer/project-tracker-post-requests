//
//  CreateProjectViewController.swift
//  project-tracker-post-requests
//
//  Created by Levi Davis on 9/12/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class CreateProjectViewController: UIViewController {
    
    @IBOutlet weak var projectNameTextField: UITextField!
    @IBOutlet weak var projectDatePickerOutlet: UIDatePicker!
    @IBOutlet weak var createButtonOutlet: UIButton!
    

    @IBAction func createButtonPressed(_ sender: UIButton) {
        guard let project = createProjectFromFields() else {
            return
        }
        
        ProjectAPIClient.manager.postProject(project: project) { (result) in
            switch result {
            case .success(let success):
               self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: Lifecylce Function
    private func createProjectFromFields() -> Project? {
        guard let name = projectNameTextField.text else {return nil}
        return Project(name: name, dueDate: formatAirTableDate(date: projectDatePickerOutlet.date))
    }
    private func formatAirTableDate(date: Date) -> String {
        return date.description.components(separatedBy: .whitespaces)[0]
    }

}
