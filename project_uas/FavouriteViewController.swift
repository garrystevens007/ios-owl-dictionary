//
//  FavouriteViewController.swift
//  project_uas
//
//  Created by Garry on 11/02/21.
//  Copyright © 2021 Garry. All rights reserved.
//

import UIKit
import CoreData

struct Dummy{
    var title: String?
    var desc: String?
}
class FavouriteViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    var moveArr: WordData?
    var idTitle: String?
    var deleteIdx: Int?
    var arrDataJson = [WordData]()
    let ctx = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        self.tableView.reloadData()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        getData()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDataJson.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favourite_detail"{
            let dest = segue.destination as! SearchViewController
            dest.dataFromFavourite = self.moveArr
            dest.idx = self.deleteIdx
            dest.key = self.idTitle
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moveArr = arrDataJson[indexPath.row]
        idTitle = arrDataJson[indexPath.row].word
        print("prepare idTitle \(idTitle)")
        deleteIdx = indexPath.row
        performSegue(withIdentifier: "favourite_detail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        var tempDel = [WordData]()
        var fetchNS = NSFetchRequest<NSFetchRequestResult>(entityName: "WordData")
        fetchNS.predicate = NSPredicate(format: "word = %@", arrDataJson[indexPath.row].word as! CVarArg)
        if editingStyle == .delete{
            do{
                tempDel = try ctx.fetch(fetchNS) as! [WordData]
                
                for data in tempDel{
                    ctx.delete(data)
                }
                
                try ctx.save()
            }catch{
                
            }
            arrDataJson.remove(at: indexPath.row)
        }
        self.tableView.reloadData()
    }
    
    func getData(){
        let requestWord = NSFetchRequest<NSFetchRequestResult>(entityName: "WordData")
//        let defModel = NSFetchRequest<NSFetchRequestResult>(entityName: "DefModeld")
//        do{
//            let wordResult = try ctx.fetch(requestWord) as! [NSManagedObject]
//            let wordDef = try ctx.fetch(defModel) as! [NSManagedObject]
//            for word in wordResult{
//                let thisWord = word.value(forKey: "word")
//                let thisPron = word.value(forKey: "pronunciation")
//                for def in wordDef{
//                    let thisDef = def.value(forKey: "definition")
//                    let thisEx = def.value(forKey: "example")
//                    let thisEm = def.value(forKey: "emoji")
//                    let thisUrl = def.value(forKey: "image_url")
//                    let thisType = def.value(forKey: "type")
//                }
//                arrDataJson.append(Data(kata: thisWord, pronounciation: String))
//            }
//        }catch{
//
//        }
        do{
            arrDataJson = try ctx.fetch(requestWord) as! [WordData]
        }catch let error{
            print(error.localizedDescription)
        }
        self.tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let dummy = arrDataJson[indexPath.row]
        cell?.textLabel?.text = dummy.word
        print(dummy.word)
        cell?.detailTextLabel?.text = dummy.pronunciation
        return cell!
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
