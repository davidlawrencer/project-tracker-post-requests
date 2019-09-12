//
//  ClientViewController.swift
//  project-tracker-post-requests
//
//  Created by Levi Davis on 9/12/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ClientViewController: UIViewController {

    @IBOutlet weak var clientTableView: UITableView!
    
    var clients = [Fields]() {
        didSet {
            clientTableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    private func configureTableView() {
        clientTableView.dataSource = self
        clientTableView.delegate = self
    }
        
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.destination is ShowEpisodeViewController {
//            guard let indexPath = showTableView.indexPathForSelectedRow,
//                let episodeVC = segue.destination as? ShowEpisodeViewController else {return}
//            let oneShow = shows[indexPath.row]
//            episodeVC.oneShow = oneShow
//        }
//    }
//
    private func loadData() {
        ClientAPIClient.manager.getClients { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let clients):
                    self.clients = clients
                case .failure(let error):
                    self.displayErrorAlert(with: error)
                }
            }
        }
    }
    private func displayErrorAlert(with error: AppError) {
        let alertVC = UIAlertController(title: "Error Fetching Data", message: "\(error)", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}

extension ClientViewController: UITableViewDelegate{}

extension ClientViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = clientTableView.dequeueReusableCell(withIdentifier: "clientCell", for: indexPath) as? ClientTableViewCell {
          let oneClient = clients[indexPath.row]
            
            cell.clientNameLabel.text = oneClient.Name
            ImageHelper.getImage(stringURL: oneClient.Logo[0].url) { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    DispatchQueue.main.async {
                         cell.clientImageView.image = data
                    }
                   
                }
                
            }
            
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}
