//
//  RegistrarUsuarioViewController.swift
//  appBiblioteca
//
//  Created by DAMII on 10/11/23.
//

import UIKit
import Alamofire


class RegistrarUsuarioViewController: UIViewController {

    
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtPaterno: UITextField!
    @IBOutlet weak var txtMaterno: UITextField!
    @IBOutlet weak var txtCelular: UITextField!
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtPassword.isSecureTextEntry = true
        self.view.backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 112/255, alpha: 1.0)
    }
    

    @IBAction func RegistrarCuenta(_ sender: Any) {
        let usuario = UsuarioEntity(nombre: txtNombre.text ?? "",
                                         paterno: txtPaterno.text ?? "",
                                         materno: txtMaterno.text ?? "",
                                         celular: txtCelular.text ?? "",
                                         correo: txtCorreo.text ?? "",
                                         username: txtUsername.text ?? "",
                                         password: txtPassword.text ?? "")

            AF.request("https://spring-api-libro.onrender.com/api/usuario/registrar",
                       method: .post,
                       parameters: usuario,
                       encoder: JSONParameterEncoder.default).responseDecodable(of: RegistroResponse.self) { response in
                switch response.result {
                case .success(let registroResponse):
                    DispatchQueue.main.async {
                        self.mostrarAlerta(mensaje: registroResponse.message)
                        if registroResponse.message == "Usuario Registrado correctamente" {
                            self.limpiarCampos()
                        }
                    }
                case .failure(let error):
                    print(error)
                    self.mostrarAlerta(mensaje: "Error al procesar la respuesta")
                }
            }
    }
    
    
    func mostrarAlerta(mensaje: String) {
        let alerta = UIAlertController(title: "Info", message: mensaje, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alerta.addAction(okAction)
        present(alerta, animated: true, completion: nil)
    }
   
    
    func limpiarCampos() {
        txtNombre.text = ""
        txtPaterno.text = ""
        txtMaterno.text = ""
        txtCelular.text = ""
        txtCorreo.text = ""
        txtUsername.text = ""
        txtPassword.text = ""
    }
    
}
