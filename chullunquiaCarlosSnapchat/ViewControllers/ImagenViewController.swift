//
//  ImagenViewController.swift
//  chullunquiaCarlosSnapchat
//
//  Created by MAC31 on 7/11/22.
//

import UIKit
import FirebaseStorage


class ImagenViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var imagePicker = UIImagePickerController()
    
    @IBAction func camaraTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker,animated: true,completion: nil)
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
 
    @IBOutlet weak var descripcionTextField: UITextField!
    
    @IBOutlet weak var elegirContactoBoton: UIButton!
    
    
    
    @IBAction func elegirContactoTapped(_ sender: Any) {
        self.elegirContactoBoton.isEnabled = false
        let imagenesFolder = Storage.storage().reference().child("imagenes")
        let imagenData = imageView.image?.jpegData(compressionQuality: 0.50)
        let cargarImagen = imagenesFolder.child("\(NSUUID().uuidString).jpg").putData(imagenData!, metadata: nil){
            (metadata,error) in
            if error != nil {
                print("ocurrio un error al subir: \(error) ")
            }else{
                self.performSegue(withIdentifier: "seleccionarContactoSegue", sender: nil)
            }
        }
        let alertaCarga = UIAlertController(title: "CARGANDO imagen", message: "0%", preferredStyle: .alert)
        let progresoCarga : UIProgressView = UIProgressView(progressViewStyle: .default)
        cargarImagen.observe(.progress) {(snapshot) in
            let porcentaje = Double (snapshot.progress!.completedUnitCount)
            / Double(snapshot.progress!.totalUnitCount)
        print(porcentaje)
            progresoCarga.setProgress(Float(porcentaje), animated: true)
            progresoCarga.frame = CGRect(x:10, y: 70, width: 250, height:0)
            alertaCarga.message = String(round(porcentaje*100.0)) + " %"
            if porcentaje>=1.0{
                alertaCarga.dismiss(animated: true,completion: nil)
            }
            
        }
        let btnOk = UIAlertAction(title: "Aceptar", style: .default,handler: nil)
        alertaCarga.addAction(btnOk)
        alertaCarga.view.addSubview(progresoCarga)
        present(alertaCarga,animated: true,completion: nil)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        elegirContactoBoton.isEnabled=false
 
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        elegirContactoBoton.isEnabled = true
        imagePicker.dismiss(animated: true,completion: nil)
    }
    func mostrarAlerta(titulo:String, mensaje:String, accion:String){
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let btnCANCELOK = UIAlertAction(title: accion, style: .default,handler: nil)
        alerta.addAction(btnCANCELOK)
        present(alerta,animated: true,completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            }
    
    
    
    
    

}
