//
//  DataManager.swift
//  GCD Practice
//
//  Created by POYEH on 2020/1/14.
//  Copyright © 2020 POYEH. All rights reserved.
//

import Foundation
import UIKit


enum Result<T> {

    case success(T)

    case failure(Error)
}




class DataManager {
    
    func fetchData(endPoint:String, completion:@escaping (Result<DataDetails>) -> Void) {
        
    let urlString = "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=5012e8ba-5ace-4821-8482-ee07c147fd0a&limit=1&offset=" + endPoint
        
        let dataUrl = URL(string: urlString)
        
        var request = URLRequest(url: dataUrl!)
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: dataUrl!) { (data, response, error) in
            
            guard let jsonData = data else { return }
            
            let decoder = JSONDecoder()
            
            do {

                let myData = try decoder.decode(DataDetails.self, from: jsonData)
                
                completion(.success(myData))

            } catch {
                
                print(error)
                
                completion(.failure(error))
                
            }
            
        }
        
        task.resume()
        
    }
    
    
}
