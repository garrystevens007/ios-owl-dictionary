//
//  DataModel.swift
//  project_uas
//
//  Created by Garry on 11/02/21.
//  Copyright © 2021 Garry. All rights reserved.
//

import Foundation

struct Data: Codable{
    var definitions: [DefModel]?
    var word: String?
    var pronunciation: String?
    
    init(deftype:DefModel.Type ,kata:String, pronounciation:String) {
        self.word = kata
        self.pronunciation = pronounciation
    }
    
}

struct DefModel : Codable{
    var type: String?
    var definition: String?
    var example: String?
    var image_url: String?
    var emoji: String?
}
