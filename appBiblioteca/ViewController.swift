//
//  ViewController.swift
//  appBiblioteca
//
//  Created by DAMII on 10/11/23.
//

import UIKit

import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUsuario: UITextField!
    

    @IBOutlet weak var usuariologo: UIImageView!
    
    var IdUsuario:Int = 0
    var Descrip:String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtPassword.isSecureTextEntry = true
        usuariologo.image=UIImage(named: "libros")

    }

    @IBAction func btnRegistrarUsuario(_ sender: UIButton) {
        performSegue(withIdentifier: "registrarUsuario", sender: self)
    }
    
    @IBAction func IniciarSesion(_ sender: UIButton) {
        let usuario = txtUsuario.text!
        let clave = txtPassword.text!
        
        let obj = LogginEntity(username: usuario, password: clave)
        
        realizarSolicitudLogin(obj: obj)
    }
    
    
    func realizarSolicitudLogin(obj: LogginEntity) {
        AF.request("https://spring-api-libro.onrender.com/api/usuario/loggin",
                   method: .post,
                   parameters: obj,
                   encoder: JSONParameterEncoder.default
        ).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    print("Error: Data es nula")
                    return
                }
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    if let jsonDict = jsonResponse as? [String: Any] {
                        if let mensaje = jsonDict["message"] as? String {
                            DispatchQueue.main.async {
                                self.mostrarAlerta(mensaje: mensaje)
                            }
                        } else if let id = jsonDict["id"] as? Int, let descripcion = jsonDict["descripcion"] as? String {
                            DispatchQueue.main.async {
                                let mensaje = "Inicio de sesion exitoso"
                                self.mostrarAlerta(mensaje: mensaje)
                            }
                            // Guardar el ID y la descripción en variables
                            self.guardarIDyDescripcion(id: id, descripcion: descripcion)
                            // Continuar con el flujo de la aplicación según sea necesario
                            //aqui deberia redirigir
                            self.navegarSegunRol()
                        } else {
                            self.mostrarAlerta(mensaje: "Respuesta inesperada")
                        }
                    } else {
                        self.mostrarAlerta(mensaje: "Error al procesar la respuesta")
                    }
                } catch let error {
                    print(error.localizedDescription)
                    self.mostrarAlerta(mensaje: "Error al procesar la respuesta")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func guardarIDyDescripcion(id: Int, descripcion: String) {
        // Aquí puedes guardar el ID y la descripción en variables para su posterior uso
        // Por ejemplo:
        self.IdUsuario = id
        self.Descrip = descripcion
    }

    func mostrarAlerta(mensaje: String) {
        let alerta = UIAlertController(title: "Info", message: mensaje, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alerta.addAction(okAction)
        present(alerta, animated: true, completion: nil)
    }
     
    
    func navegarSegunRol() {
        if Descrip == "Administrador" {
            performSegue(withIdentifier: "adminSegue", sender: self)
            print("administrador")
        } else if Descrip == "Visitante" {
            performSegue(withIdentifier: "visitanteSegue", sender: self)
            print("visitante")
        } else {
            print("Rol desconocido")
        }
    }

    

    
}

