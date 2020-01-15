//
//  ViewController.swift
//  GCD Practice
//
//  Created by POYEH on 2020/1/14.
//  Copyright © 2020 POYEH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var roadOne: UILabel!
    @IBOutlet weak var roadTwo: UILabel!
    @IBOutlet weak var roadThree: UILabel!
    @IBOutlet weak var limitOne: UILabel!
    @IBOutlet weak var limitTwo: UILabel!
    @IBOutlet weak var limitThree: UILabel!
    
    
    let dataManager = DataManager()
    let endPoint = ["0", "10", "20"]
    
    var data: [DataDetails] = []
    var roads: [String] = []
    var speedLimits: [String] = []
    

    override func viewDidLoad() {
        //let newQueue = DispatchQueue(label: "newQueue")
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.getData(numberForEndPoint: "0", roadLabel: self.roadOne, speedLimitLabel: self.limitOne)
        }
        
        DispatchQueue.main.async {
            self.getData(numberForEndPoint: "10", roadLabel: self.roadTwo, speedLimitLabel: self.limitTwo)
        }
        
        DispatchQueue.main.async {
            self.getData(numberForEndPoint: "20", roadLabel: self.roadThree, speedLimitLabel: self.limitThree)
        }
        
    }

    func getData(numberForEndPoint: String, roadLabel: UILabel, speedLimitLabel: UILabel){
        
        self.dataManager.fetchData(endPoint: numberForEndPoint, completion: { (result) in
            
            switch result {
                
            case .success(let data):
                let nameOfRoad = data.result.results[0].road
                let speedLimit = data.result.results[0].speedLimit
                roadLabel.text = nameOfRoad
                speedLimitLabel.text = speedLimit
            case .failure(let error): print(error)
            
            }
        })
    }

}

