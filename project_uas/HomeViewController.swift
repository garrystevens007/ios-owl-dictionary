//
//  HomeViewController.swift
//  project_uas
//
//  Created by Garry on 11/02/21.
//  Copyright © 2021 Garry. All rights reserved.
//

import UIKit



class HomeViewController: UIViewController {
    var key: String?
    var flag = true
    var tempData: Data?
    var random = ["Bald","Normal","Mall","Park","Exhausted","Tired","Happy","Different","Also","Moon"]
    @IBOutlet weak var txtSearch: UITextField!
    @IBAction func btnSearch(_ sender: Any) {
        if(txtSearch.text?.count)! == 0 {
            showAlert(title: "Alert", message: "Please fill the box to continue.")
        }else if(txtSearch.text?.count)! < 3 {
            showAlert(title: "Alert", message: "Words is too short.")
        }else{
            key = txtSearch.text
            load(key!)
        }
        
    }
    @IBAction func btnRandom(_ sender: Any) {
        let randomInt = Int.random(in: 0..<10)
        var str = random[randomInt]
        txtSearch.text = str
        print(str)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "search_detail"{
            let destination = segue.destination as! SearchViewController
            
            destination.dataModel = self.tempData
            destination.key = self.key
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    @IBAction func unwind ( _segue: UIStoryboardSegue){

    }
    
    func showAlert(title: String,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let setAction = UIAlertAction(title: "Understand", style: .default, handler: nil)


        alert.addAction(setAction)
        present(alert,animated: true,completion: nil)
    }
    let baseURL = "https://owlbot.info/api/v4/dictionary"
    func load(_ key: String){
        let url = URL(string: "\(baseURL)/\(key.lowercased() as! String)")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("Token 1ad61a70f82c85717b939b0e9552bdda8aef6122", forHTTPHeaderField: "Authorization")
            URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in

                guard let data = data, error == nil else{
                    print("something error here")
                    return
                }
                
                //var result: Data?
                do{
                    self.flag = true
                    self.tempData = try JSONDecoder().decode(Data.self
                        , from: data)
                }catch{
                    print("failed to convert \(error.localizedDescription)")
                    self.flag = false
                    print(self.flag)
                }
                
//                guard let json = self.tempData else{
//                    return
//                }
                
            DispatchQueue.main.async {
                print("flag value dispatch \(self.flag)")
                if self.flag == false{
                    print("triggered")
                    self.showAlert(title: "Request Error", message: "No definition found :(")
                    return
                }
                self.performSegue(withIdentifier: "search_detail", sender: nil)
                                       self.tempData = nil
                
            }
//                print(json.word)
//                print(json.pronunciation)
//                print(json.definitions?[0].type)
//                print(json.definitions?[0].example)
                
            }).resume()
        }

}
