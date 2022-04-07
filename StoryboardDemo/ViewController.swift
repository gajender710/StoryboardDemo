//
//  ViewController.swift
//  StoryboardDemo
//
//  Created by Gajender Jangir on 30/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var userfield: UITextField!
    @IBOutlet weak var passwordfield: UITextField!
    @IBOutlet weak var switchBtn: UISwitch!
    
    @IBOutlet weak var forgotBtnAlert: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
          
        userfield.attributedPlaceholder=NSAttributedString(string: "Enter username",attributes: [NSAttributedString.Key.foregroundColor : UIColor.blue])
        passwordfield.attributedPlaceholder=NSAttributedString(string: "Enter password",attributes: [NSAttributedString.Key.foregroundColor : UIColor.blue])
        
        
        forgotBtnAlert.addTarget(self, action: #selector(updateAlertWithTextfield), for: .touchUpInside)
        let uservalue=UserDefaults.standard.string(forKey: "userfieldata")
        if uservalue != nil{
            userfield.text=uservalue
        }
        let passvalue=UserDefaults.standard.string(forKey: "passfieldata")
        if passvalue != nil{
            passwordfield.text=passvalue
        }
        
        
        let switchState=UserDefaults.standard.bool(forKey: "switchIsOn")
        if switchState == true{
            switchBtn.setOn(true, animated: true)
        }
        else{
            switchBtn.setOn(false, animated: true)
        }
        
        getData()
       
        // Do any additional setup after loading the view.
    }

    func getData() {
        guard let url=URL(string: "https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400&date=2020-10-07")else{return}
        
        URLSession.shared.dataTask(with: url){data,response,error in
//            print("getData error \(error)")
//            print("getData data \(data)")
            guard let data = data, error == nil else { fatalError("data is not received") }
                //var result:Response?
            let result:Response
                do {
                    let result=try JSONDecoder().decode(Response.self, from: data)
                    //let result=try? JSONSerialization.jsonObject(with: data, options: []) as [[String:Any]]
                    print(result.status)
                    print(result.results.civil_twilight_end)
                    print(result.results.astronomical_twilight_begin)
                    print(result.results.sunrise)

                }
                catch{
                    //print(String(describing: error))
                    print("failed \(error.localizedDescription)")
                }

        }.resume()
    }
    
    
    
    @objc func updateAlert()
    {
        let alertView=UIAlertController(title: "Forgot password", message: "Want to renew your password", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "NO", style: .cancel, handler: nil))
        alertView.addAction(UIAlertAction(title: "Yes", style: .default,handler: { (_) in
            print("yes is tapped")
        }))
        
        self.present(alertView, animated: true, completion: nil)
    }
    @objc func updateAlertWithTextfield()
    {
        let alertView=UIAlertController(title: "Enter mail", message: "check your mail box after submit", preferredStyle: .alert)
        
        alertView.addTextField(configurationHandler: nil)
        alertView.textFields![0].placeholder="Enter email"
        
        alertView.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertView.addAction(UIAlertAction(title: "Submit", style: .default,handler: { (_) in
            print(alertView.textFields![0].text ?? nil ?? "")
        }))
        
        self.present(alertView, animated: true, completion: nil)
    }
    
    @IBAction func RememberMeSwitch(_ sender: UISwitch) {
        if sender.isOn{
            UserDefaults.standard.set(userfield.text, forKey: "userfieldata")
            UserDefaults.standard.set(passwordfield.text, forKey: "passfieldata")
            UserDefaults.standard.set(true, forKey: "switchIsOn")
        }
        else{
            UserDefaults.standard.set("", forKey: "userfieldata")
            UserDefaults.standard.set("", forKey: "passfieldata")
            UserDefaults.standard.set(false, forKey: "switchIsOn")
        }
        
    }
    
}



struct Response: Codable {
    let results: MyResult
    let status: String
}

struct MyResult: Codable {

    let sunrise: String
    let sunset: String
    let solar_noon: String
    let day_length: String
    let civil_twilight_begin: String
    let civil_twilight_end: String
    let nautical_twilight_begin: String
    let nautical_twilight_end: String
    let astronomical_twilight_begin: String
    let astronomical_twilight_end: String
    
}



