//
//  ViewController.swift
//  chullunquiaCarlosSnapchat
//
//  Created by MAC31 on 31/10/22.
//

import UIKit
import Firebase
import FirebaseAuth

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
            }else{
                print("inicio de sesion exitoso")
            }
        }
    }

}

