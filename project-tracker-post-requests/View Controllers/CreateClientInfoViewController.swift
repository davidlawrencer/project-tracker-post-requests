//
//  CreateClientInfoViewController.swift
//  project-tracker-post-requests
//
//  Created by Levi Davis on 9/12/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class CreateClientInfoViewController: UIViewController {
    @IBOutlet weak var clientNameTextField: UITextField!
    @IBOutlet weak var clientSummaryTextField: UITextField!
    
    @IBAction func createClientButtonPressed(_ sender: UIButton) {
        guard let client = createClientFromFields() else {return} ClientAPIClient.manager.postClient(client: client) { (result) in
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
    

    private func createClientFromFields() -> Client? {
        guard let name = clientNameTextField.text else {return nil}
        guard let about = clientSummaryTextField.text else {return nil}
        return Client(Name: name, Logo: nil, About: about)
    }

}
