//
//  DetailTableViewCell.swift
//  project_uas
//
//  Created by Garry on 11/02/21.
//  Copyright © 2021 Garry. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtType: UILabel!
    @IBOutlet weak var txtDef: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
