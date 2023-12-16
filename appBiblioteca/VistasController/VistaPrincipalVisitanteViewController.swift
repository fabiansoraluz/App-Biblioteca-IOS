//
//  VistaPrincipalVisitanteViewController.swift
//  appBiblioteca
//
//  Created by DAMII on 10/11/23.
//

import UIKit

class VistaPrincipalVisitanteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func btnListar(_ sender: UIButton) {
        performSegue(withIdentifier: "verLibro", sender: self)
    }
}
