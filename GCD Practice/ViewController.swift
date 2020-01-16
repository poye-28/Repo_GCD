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
        
        //gcdGroup()
        URLSession.shared.delegateQueue.maxConcurrentOperationCount = 10
        
        gcdSemaphore()

    }

    func getData(numberForEndPoint: String, completion: @escaping (Result<DataDetails>) -> Void ){
        
        self.dataManager.fetchData(endPoint: numberForEndPoint, completion: { (result) in
            
            
            switch result {
                
            case .success(let data):
                
//                let road = data.result.results[0].road
//
//                let speedLimit = data.result.results[0].speedLimit
//
//                self.roads.append(road)
//
//                self.speedLimits.append(speedLimit)
                
//                self.group.leave()
                
                completion(.success(data))
        
            case .failure(let error):
                
                print(error)
            
                completion(.failure(error))
                
            }
        })
    }
    
//    func gcdGroup() {
//
//        DispatchQueue.main.async(group: group) {
//
//            self.group.enter()
//            self.getData(numberForEndPoint: "0", roadLabel: self.roadOne, speedLimitLabel: self.limitOne)
//
//        }
//
//        DispatchQueue.main.async(group: group) {
//
//            self.group.enter()
//            self.getData(numberForEndPoint: "10", roadLabel: self.roadTwo, speedLimitLabel: self.limitTwo)
//
//        }
//
//        DispatchQueue.main.async(group: group) {
//
//            self.group.enter()
//            self.getData(numberForEndPoint: "20", roadLabel: self.roadThree, speedLimitLabel: self.limitThree)
//
//        }
//
//        group.notify(queue: DispatchQueue.main){
//            self.roadOne.text = self.roads[0]
//            self.roadTwo.text = self.roads[1]
//            self.roadThree.text = self.roads[2]
//            self.limitOne.text = self.speedLimits[0]
//            self.limitTwo.text = self.speedLimits[1]
//            self.limitThree.text = self.speedLimits[2]
//        }
//
//    }
    
    func gcdSemaphore() {

            self.getData(numberForEndPoint: "0", completion: {(result) in
                
                switch result {
                    
                    case .success(let data):
                        
                        DispatchQueue.main.async {
                            
                            self.roadOne.text = data.result.results[0].road
                            
                            self.limitOne.text = data.result.results[0].speedLimit
                            
                            self.semaphoreOne.signal()
                            
                            print("1")
                            
                        }
                        
                    case .failure(let error):
                    
                        print(error)
                    
                        self.semaphoreOne.signal()
                    
                }
                
            })

//            self.roadOne.text = self.roads[0]
//            self.limitOne.text = self.speedLimits[0]

                self.getData(numberForEndPoint: "10", completion: {(result) in
                    
                    self.semaphoreOne.wait()
                    
                    switch result {
                        
                        case .success(let data):
                            
                            DispatchQueue.main.async {
                                
                                self.roadTwo.text = data.result.results[0].road
                                
                                self.limitTwo.text = data.result.results[0].speedLimit
                                
                                self.semaphoreTwo.signal()
                                
                                print("2")
                                
                            }
                            
                        case .failure(let error):
                        
                            print(error)
                        
                            self.semaphoreTwo.signal()
                        
                    }
                
            })

//            self.roadTwo.text = self.roads[1]
//            self.limitTwo.text = self.speedLimits[1]

                self.getData(numberForEndPoint: "20", completion: {(result) in
                    
                    self.semaphoreTwo.wait()
                
                    switch result {
                        
                        case .success(let data):
                            
                            DispatchQueue.main.async {
                                
                                self.roadThree.text = data.result.results[0].road
                                
                                self.limitThree.text = data.result.results[0].speedLimit
                                
                                print("3")
                                
                            }
                            
                        case .failure(let error):
                        
                            print(error)
                        
                    }
                
            })

//            self.roadThree.text = self.roads[2]
//            self.limitThree.text = self.speedLimits[2]

    }
    
    
    

}

