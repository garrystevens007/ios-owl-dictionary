//
//  SearchViewController.swift
//  project_uas
//
//  Created by Garry on 11/02/21.
//  Copyright © 2021 Garry. All rights reserved.
//

import UIKit
import CoreData

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tvList: UITableView!
    @IBOutlet weak var txtWord: UILabel!
    @IBOutlet weak var txtPronoun: UILabel!
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    var ctx: NSManagedObjectContext!
    var starFill = UIImage(systemName: "star.fill")
    var star = UIImage(systemName: "star")
    var dataModel: Data?
    var idx: Int?
    var key: String?
    var coreData = [WordData]()
    var dataFromFavourite: WordData?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//    override func viewWillAppear(_ animated: Bool) {
//        if validateWords() == false{
//            starBtn.image = starFill
//        }else{
//            starBtn.image = star
//        }
//    }
    @IBAction func saveWord(_ sender: Any) {
        favourite()
        //showAlert(title: "Save Success", message: "Returning to main menu")
    }
    func showAlert(title: String,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let setAction = UIAlertAction(title: "Save", style: .default){(action) in
            self.performSegue(withIdentifier: "backToMain", sender: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(setAction)
        alert.addAction(cancel)
        present(alert,animated: true,completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("from model \(dataModel?.word)")
        
        
        if dataFromFavourite != nil{
            btnFav.isHidden = true
            if dataFromFavourite?.toArray[0].image_url != nil{
                loadImage((dataFromFavourite?.toArray[0].image_url))
            }
            txtWord.text = dataFromFavourite?.word
            txtPronoun.text = dataFromFavourite?.pronunciation
        }else{
            validateFav((dataModel?.word)!)
            if dataModel?.definitions![0].image_url != nil{
                loadImage((dataModel?.definitions![0].image_url))
            }
            txtWord.text = dataModel?.word
            txtPronoun.text = dataModel?.pronunciation
        }
        
        tvList.dataSource = self
        self.tvList.reloadData()
        //favourite()
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataFromFavourite != nil{
            return dataFromFavourite?.toArray.count ?? 1
        }else{
            return dataModel?.definitions?.count ?? 1
        }
        
    }
    
//    func validateWords() -> Bool{
//        getData()
//        let count = coreData.count
//        var ctx = WordData(context: context)
//        ctx.word = key
//        var idx = 0
//        while idx < count{
//            if ctx.word == coreData[idx].word{
//                return false//terjadi dupilkasi data
//            }
//        }
//        return true
//    }
//
//    func getData(){
//            let requestWord = NSFetchRequest<NSFetchRequestResult>(entityName: "WordData")
//            do{
//                coreData = try ctx.fetch(requestWord) as! [WordData]
//            }catch let error{
//                print(error.localizedDescription)
//            }
//    }
    func favourite(){
        //create word
        var words = WordData(context: context)
        words.word = dataModel?.word
        words.pronunciation = dataModel?.pronunciation
        //create wordDef
        var totalDef = (dataModel?.definitions?.count)!
        print("numbs of def \(totalDef)")
        var idx = 0
        while idx < totalDef{
            let wordDef = DefModeld(context: context)
            wordDef.definition = dataModel?.definitions?[idx].definition
            wordDef.example = dataModel?.definitions?[idx].example
            wordDef.type = dataModel?.definitions?[idx].type
            wordDef.image_url = dataModel?.definitions?[idx].image_url
            wordDef.emoji = dataModel?.definitions?[idx].emoji
            print(wordDef.type)
            idx += 1
            words.addToDefinitons(wordDef)
        }
        //save
        try! context.save()
        print("success save")
    }
    
    func validateFav(_ kata: String){
        var wordKey = [WordData]()
        var fetchNS = NSFetchRequest<NSFetchRequestResult>(entityName: "WordData")
        fetchNS.predicate = NSPredicate(format: "word = %@", kata.lowercased() as! CVarArg)
        do{
            wordKey = try context.fetch(fetchNS) as! [WordData]
        }catch{
            
        }
        if wordKey.count > 0{
            btnFav.isHidden = true
        }else{
            btnFav.isHidden = false
        }
    }
    
    func loadImage(_ link: String?){
        var url = URL(string: "\(link!)")
        var request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil{
                print(error)
                return
            }
            self.imgView.image =  UIImage(data: data!)
            })
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvList.dequeueReusableCell(withIdentifier: "detail_cell") as! DetailTableViewCell
        if dataFromFavourite != nil{
            let dataFF = dataFromFavourite?.toArray[indexPath.row]
            cell.txtTitle.text = dataFF?.type
            cell.txtType.text = dataFF?.definition
            cell.txtDef.text = dataFF?.example
        }else{
            let data = dataModel?.definitions?[indexPath.row]
            cell.txtTitle.text = data?.type
            cell.txtType.text = data?.definition
            cell.txtDef.text = data?.example
            print("cell")
            print("this from cell \(cell.txtTitle.text)")
        }
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
