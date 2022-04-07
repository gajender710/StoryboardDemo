//
//  ViewController.swift
//  StoryboardDemo
//
//  Created by Gajender Jangir on 30/03/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
               
        getData()
        
        
        
        // Do any additional setup after loading the view.
    }

    func getData()
    {
        guard let url=URL(string: "https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400&date=today")else{return}
        
        URLSession.shared.dataTask(with: url){data,response,error in
                            
            guard let data = data,error==nil else {
                print("data is not received")
                return
            }
                var result:Response?
                do{
                    result=try JSONDecoder().decode(Response.self, from: data)
                }
                catch{
                    print("failed \(error.localizedDescription)")
                }
                guard let json=result else{return}
                print(json.status)
                print(json.results.dayLength)
                print(json.results.civilTwilightBegin)

        }.resume()
    }
}


struct Response: Codable {
    let results: MyResults
    let status: String
}

struct MyResults: Codable {
    
    let sunrise: String
    let sunset: String
    let solarNoon: String
       let dayLength: Int
       let civilTwilightBegin, civilTwilightEnd, nauticalTwilightBegin, nauticalTwilightEnd: String
       let astronomicalTwilightBegin, astronomicalTwilightEnd: String
//    let sunrise: String
//    let sunset: String
//    let solarNoon: String
//    let dayLength: Int
//    let civilTwilightBegin : String
//    let civilTwilightEnd : String
//    let nauticalTwilightBegin : String
//    let nauticalTwilightEnd : String
//    let astronomicalTwilightBegin: String
//    let astronomicalTwilightEnd: String
}

