//
//  VistaPrincipalAdministradorViewController.swift
//  appBiblioteca
//
//  Created by DAMII on 10/11/23.
//

import UIKit
import Alamofire

class VistaPrincipalAdministradorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tvLibros: UITableView!
    
    var pos = 0
    
    var listaLibros:[LibrosEntity]=[]
    let refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tvLibros.dataSource=self
        //alto de la celda
        tvLibros.rowHeight=175
        //delegado
        tvLibros.delegate=self
        
        CargarLibros()
        
        
        //refresca tabla
        refresh.addTarget(self, action: #selector(refrescarTabla(_:)), for: .valueChanged)
        tvLibros.refreshControl=refresh
    }
    
    @objc func refrescarTabla(_ sender: Any){
        print("Recargando")
        CargarLibros()
        tvLibros.dataSource=self
        tvLibros.delegate=self
        tvLibros.rowHeight=175
        tvLibros.reloadData()
        refresh.endRefreshing()
    }
    
    
    func CargarLibros(){
            AF.request("https://spring-api-libro.onrender.com/api/libro/lista").responseDecodable(of: [LibrosEntity].self){
                response in
                guard let datos=response.value else {return}
                self.listaLibros=datos
                self.tvLibros.reloadData()
            }
        }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaLibros.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //crear objeto de la clase ItemTableViewCell
        var row=tvLibros.dequeueReusableCell(withIdentifier: "itemLibro") as!
        itemLibrosAdmTableViewCell
        //asignar valores
        row.lblTitulo.text=String(listaLibros[indexPath.row].titulo)
        row.lblAutor.text=listaLibros[indexPath.row].autor
        row.lblGenero.text=listaLibros[indexPath.row].genero.nombre
        
        if let url = URL(string: listaLibros[indexPath.row].portada) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            row.imgPortada.image = UIImage(data: data)
                        }
                    }
                }
            }
        
        return row
    }
    
    @IBAction func btnNuevo(_ sender: UIButton) {
        performSegue(withIdentifier: "newlibro", sender: self)
    }
}
