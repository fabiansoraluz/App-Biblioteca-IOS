//
//  LibroVisitanteViewController.swift
//  appBiblioteca
//
//  Created by DAMII on 17/11/23.
//

import UIKit
import Alamofire
import Kingfisher

class LibroVisitanteViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
 

    
    @IBOutlet weak var CvLibro: UICollectionView!
    
    var listaLibros:[LibrosEntity]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        CvLibro.dataSource = self
        CvLibro.delegate = self
        cargarLibro()
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listaLibros.count
    }
    
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "row", for: indexPath) as!
        itemLibroVisCollectionViewCell
        cell.lblTitulo.text = listaLibros[indexPath.row].titulo
        cell.lblAutor.text = listaLibros[indexPath.row].autor
        cell.lblGenero.text = listaLibros[indexPath.row].genero.nombre
        cell.lblDescripcion.text = listaLibros[indexPath.row].descripcion
        let url = URL(string: listaLibros[indexPath.row].portada)
        cell.imgPortada.kf.setImage(with: url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 20) / 2
        return CGSize(width: width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let libro = listaLibros[indexPath.row]
        print("LIBRO SELECCIONADO: \(libro.titulo)")
    }
    
    func cargarLibro(){
        AF.request("https://spring-api-libro.onrender.com/api/libro/lista")
            .responseDecodable(of: [LibrosEntity].self){
                response in
                guard let datos=response.value   else {return}
                self.listaLibros=datos
                self.CvLibro.reloadData()
          }
    }
    

}
