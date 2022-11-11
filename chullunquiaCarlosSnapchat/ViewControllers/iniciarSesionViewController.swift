//
//  ViewController.swift
//  chullunquiaCarlosSnapchat
//
//  Created by MAC31 on 31/10/22.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class iniciarSesionViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func iniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {(user,error) in
            print("intentando Iniciar Sesion")
            if error != nil{
                print("se presento el siguiente error: \(error)")
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password:
                                        self.passwordTextField.text!, completion: {(user, error) in print("intentando crear un usuario")
                    if error != nil{print("se presento el siguiente error al crear el usuario: \(error)")
                    }else{
                        print("el usuario fue creado exitosamente")
                        
                        Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
                        
                        
                        let alerta = UIAlertController(title: "creacion de usuarios", message: "usuario : \(self.emailTextField.text!) se creo correctaamente.", preferredStyle: .alert)
                        let btnOK = UIAlertAction(title: "aceptar", style: .default, handler: { (UIAlertAction) in
                            self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                        })
                        alerta.addAction(btnOK)
                        self.present(alerta, animated: true,completion: nil)
                        
                        self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                    }
                })
            }else{
                print("inicio de sesion exitoso")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
        }
    }

}

