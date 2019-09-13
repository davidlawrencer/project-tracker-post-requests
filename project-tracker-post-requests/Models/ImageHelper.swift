//
//  ImageHelper.swift
//  project-tracker-post-requests
//
//  Created by Levi Davis on 9/12/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation
import UIKit

struct ImageHelper {
    private init() {}
    static let shared = ImageHelper()
    
    static func getImage(stringURL: String, completionHandler: @escaping (Result<UIImage,AppError>) -> () ) {
        guard let url = URL(string: stringURL) else {
            completionHandler(.failure(AppError.badURL))
            return
        }
        let request = URLRequest.init(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler(.failure(AppError.badURL))
            } else if let data = data {
                let foto = UIImage.init(data: data)
                completionHandler(.success(foto!))
            }
        }.resume()
        
    }
    
}
