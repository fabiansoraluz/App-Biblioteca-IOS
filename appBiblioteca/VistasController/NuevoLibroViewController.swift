//
//  NuevoLibroViewController.swift
//  appBiblioteca
//
//  Created by DAMII on 18/11/23.
//

import UIKit
import Alamofire
import DropDown
import Toaster

class NuevoLibroViewController: UIViewController {

    var listaGenero:[GeneroEntity]=[]
    let combo = DropDown()
    var indiceGeneroSeleccionado: Int?
    
    @IBOutlet weak var txtTitulo: UITextField!
    @IBOutlet weak var txtDescripcion: UITextField!
    @IBOutlet weak var txtAutor: UITextField!
    @IBOutlet weak var txtLibro: UITextField!
    @IBOutlet weak var txtPortada: UITextField!
    @IBOutlet weak var cmbGenero: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cargarGeneros()
    }
    
    func cargarGeneros(){
            AF.request("https://spring-api-libro.onrender.com/api/genero/lista").responseDecodable(of: [GeneroEntity].self){
                response in
                guard let datos=response.value else {return}
                self.listaGenero=datos
            }
        }

    @IBAction func cmbGenero(_ sender: UIButton) {
        
        combo.anchorView=sender
        combo.bottomOffset = CGPoint(x: 0, y:(combo.anchorView?.plainView.bounds.height)!)
        combo.dataSource = listaGenero.map { $0.nombre }
        combo.textFont = UIFont.systemFont(ofSize: 15.0)
        combo.show()
        combo.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            sender.setTitle(item, for: .normal)
            self.indiceGeneroSeleccionado = index
        }
        
    }
    
    
    func registrar(obj:LibrosEntity){
        AF.request("https://spring-api-libro.onrender.com/api/libro/registrar", method: .post, parameters: obj, encoder:(JSONParameterEncoder.default)).response(
        completionHandler: { data in
            switch data.result{
                case .success(let info):
                    //deserializar
                    do{
                        let result=try JSONDecoder().decode(LibrosEntity.self, from: info!)
                    }
                    catch{
                        print("Error en la deserializacion")
                        Toast(text: "Registro exitoso").show()
                        self.navigationController?.popViewController(animated: true)
                    }
                case .failure(let error):
                    print(error)
            }
        }
        )
    }

    
    @IBAction func btnRegistrar(_ sender: UIButton) {
        if txtTitulo.text==""{
            Toast(text: "Ingrese titulo.\n Campo Obligatorio.").show()
        }else if txtDescripcion.text==""{
            Toast(text: "Ingrese descripcion.\n Campo Obligatorio.").show()
        }else if txtAutor.text==""{
            Toast(text: "Ingrese autor.\n Campo Obligatorio.").show()
        }else if txtLibro.text==""{
            Toast(text: "Ingrese URL del libro.\n Campo Obligatorio.").show()
        }else if txtPortada.text==""{
            Toast(text: "Ingrese URL de portada.\n Campo Obligatorio.").show()
        }else if cmbGenero.titleLabel?.text=="Seleccione genero"{
            Toast(text: "Seleccione genero.\n Campo Obligatorio.").show()
        }
        
        let tit=txtTitulo.text ?? ""
        let des=txtDescripcion.text ?? ""
        let aut=txtAutor.text ?? ""
        let lib=txtLibro.text ?? ""
        let por=txtPortada.text ?? ""
        let gen=listaGenero[indiceGeneroSeleccionado!]
        
        let data=LibrosEntity(id: 0, titulo: tit, descripcion: des, autor: aut, archivo: lib, portada: por, registro: "", estado: true, genero: GeneroEntity(id: gen.id, nombre: ""))
        
        registrar(obj: data)
        

    }
    
}
