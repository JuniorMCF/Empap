//
//  ViewController.swift
//  Empap
//
//  Created by Junior on 2/7/20.
//  Copyright © 2020 EMPAP. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftToast
class LoginViewController: UIViewController {
    
    @IBOutlet var imgLogo: UIImageView!
    @IBOutlet var userTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        isLoggin()
        imgLogo.frame = CGRect(x:  self.view.frame.width/3 , y: self.view.frame.height/10, width: self.view.frame.width/3, height: self.view.frame.width/3)
        
        loginButton.backgroundColor = .clear
        loginButton.layer.cornerRadius = 10
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.black.cgColor

         
        //textfields styles
        
        
        userTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: userTextField.frame.height))
        userTextField.placeholder = "Usuario"
        let imageView = UIImageView(frame: CGRect(x: passwordTextField.frame.height/3, y: passwordTextField.frame.height/3, width: passwordTextField.frame.height/3, height: passwordTextField.frame.height/3))
        let image =  UIImage(named: "user-icon")
        imageView.image = image
        userTextField.addSubview(imageView)
        userTextField.leftViewMode = .always
        userTextField.rightViewMode = .always
        
        userTextField.layer.cornerRadius = 10.0
        userTextField.layer.borderWidth = 1.0
        userTextField.layer.borderColor = UIColor.black.cgColor
        
        
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: passwordTextField.frame.height))
        passwordTextField.placeholder = "Contraseña"
        let imageViewpass = UIImageView(frame: CGRect(x: passwordTextField.frame.height/3, y: passwordTextField.frame.height/3, width: passwordTextField.frame.height/3, height: passwordTextField.frame.height/3))
        let imagepass =  UIImage(named: "pass-icon")
        imageViewpass.image = imagepass
        passwordTextField.addSubview(imageViewpass)
        passwordTextField.leftViewMode = .always
        passwordTextField.rightViewMode = .always
        
        passwordTextField.layer.cornerRadius = 10.0
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.isSecureTextEntry = true
        
        
    }
    func isLoggin(){
        //verificamos is el usuario ya se ha logueado
        if(Constants().getLogin() == true){
                userTextField.text = Constants().getUsername()
                passwordTextField.text = Constants().getPassword()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "EmpresasID")
                self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
    }

    @IBAction func tapLogin(_ sender: Any) {
        var user = ""
        var clave = ""
        
        if(!userTextField.text!.isEmpty ){
            user = userTextField.text!
        }else{
            // mostrar error el label
            //Toast(text: "Usuario esta vacio", delay: 0, duration: 5).show()
            let toast = SwiftToast(text: "Usuario esta vacio")
            self.present(toast, animated: true)
            
            
        }
        if(!passwordTextField.text!.isEmpty){
            clave = passwordTextField.text!
        }else{
            // mostrar error el label
            //Toast(text: "Contraseña esta vacia", delay: 0, duration: 5).show()
            let toast = SwiftToast(text: "Contraseña esta vacia")
            self.present(toast, animated: true)
        }
        // si ambos campos estan llenos
        if(!userTextField.text!.isEmpty && !passwordTextField.text!.isEmpty){
            user = userTextField.text!
            clave = passwordTextField.text!
            
            let parameter = ["usuario" : user, "clave" : clave]
            
            // hacemos la consulta a la base de datos
                AF.request(Constants().dominio + Constants().postLogin, method: .post, parameters: parameter,encoding: JSONEncoding.default,headers:nil).responseJSON{(response) in
                        switch response.result{
                            
                        case.success(let value):
                                     let json = JSON(value)
                                     print(json)

                                     let resultado = json["resultado"].stringValue
                                     if(resultado == "200"){
                                        let response = json ["response"].stringValue
                                        
                                        Constants().saveLogin(isLogin: true)
                                        Constants().saveUsername(username: user)
                                        Constants().savePassword(password: clave)
                                        Constants().saveIdUser(id: response)
                                        
                                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                        let viewController = storyboard.instantiateViewController(withIdentifier: "EmpresasID")
                                        self.navigationController?.pushViewController(viewController, animated: true)
                                        
                                     }else if (resultado == "201")  {
                                         //usuario no existe
                                         //Toast(text: "Usuario no existe", delay: 0, duration: 5).show()
                                        let toast = SwiftToast(text: "Contraseña incorrecta")
                                        self.present(toast, animated: true)

                                     }else if (resultado == "404"){
                                         //clave incorrecta
                                        //Toast(text: "Contraseña incorrecta", delay: 0, duration: 5).show()
                                        
                                        let toast = SwiftToast(text: "Usuario no existe")
                                        self.present(toast, animated: true)
                                     }

                                             
                                         
                                   break
                                case.failure(let error):
                                    print(error)
                                    break
                            }
                        
                        
                    }
                
                
                
        }else{
            //Toast(text: "Llene los campos", delay: 0, duration: 5).show()
            let toast = SwiftToast(text: "Llene los campos")
            self.present(toast, animated: true)
            
        }
    }
        
        
    
}

