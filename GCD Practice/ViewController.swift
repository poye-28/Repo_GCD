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
    let semaphoreOne = DispatchSemaphore(value: 0)
    let semaphoreTwo = DispatchSemaphore(value: 0)
    let semaphoreThree = DispatchSemaphore(value: 0)
    let group = DispatchGroup()
    var roads = [String]()
    var speedLimits = [String]()
    var data: [DataDetails] = []

    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        gcdGroup()
        
        
//        gcdSemaphore()

    }

    func getData(numberForEndPoint: String, roadLabel: UILabel, speedLimitLabel: UILabel){
        
        self.dataManager.fetchData(endPoint: numberForEndPoint, completion: { (result) in
            
            switch result {
                
            case .success(let data):
                
                let road = data.result.results[0].road
                
                let speedLimit = data.result.results[0].speedLimit
                
                self.roads.append(road)
                
                self.speedLimits.append(speedLimit)
                
//                self.semaphoreOne.signal()
                
                self.group.leave()
        
            case .failure(let error): print(error)
            
                
                
                
                
            }
        })
    }
    
    func gcdGroup() {

        DispatchQueue.main.async(group: group) {

            self.group.enter()
            self.getData(numberForEndPoint: "0", roadLabel: self.roadOne, speedLimitLabel: self.limitOne)

        }

        DispatchQueue.main.async(group: group) {

            self.group.enter()
            self.getData(numberForEndPoint: "10", roadLabel: self.roadTwo, speedLimitLabel: self.limitTwo)

        }

        DispatchQueue.main.async(group: group) {

            self.group.enter()
            self.getData(numberForEndPoint: "20", roadLabel: self.roadThree, speedLimitLabel: self.limitThree)

        }

        group.notify(queue: DispatchQueue.main){
            self.roadOne.text = self.roads[0]
            self.roadTwo.text = self.roads[1]
            self.roadThree.text = self.roads[2]
            self.limitOne.text = self.speedLimits[0]
            self.limitTwo.text = self.speedLimits[1]
            self.limitThree.text = self.speedLimits[2]
        }

    }
    
//    func gcdSemaphore() {
//
//        DispatchQueue.main.async {
//
//            self.getData(numberForEndPoint: "0", roadLabel: self.roadOne, speedLimitLabel: self.limitOne)
//            self.semaphoreOne.wait()
//            self.roadOne.text = self.roads[0]
//            self.limitOne.text = self.speedLimits[0]
//
//
//        }
//
//        DispatchQueue.main.async {
//
//            self.getData(numberForEndPoint: "10", roadLabel: self.roadTwo, speedLimitLabel: self.limitTwo)
//            self.semaphoreOne.wait()
//            self.roadTwo.text = self.roads[1]
//            self.limitTwo.text = self.speedLimits[1]
//
//        }
//
//        DispatchQueue.main.async {
//
//            self.getData(numberForEndPoint: "20", roadLabel: self.roadThree, speedLimitLabel: self.limitThree)
//            self.semaphoreThree.wait()
//            self.roadThree.text = self.roads[2]
//            self.limitThree.text = self.speedLimits[2]
//
//        }
//
//    }
    
    
    

}

