//
//  itemLibrosAdmTableViewCell.swift
//  appBiblioteca
//
//  Created by DAMII on 13/11/23.
//

import UIKit

class itemLibrosAdmTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblAutor: UILabel!
    @IBOutlet weak var lblGenero: UILabel!
    
    @IBOutlet weak var imgPortada: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
