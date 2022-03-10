//
//  ViewController.swift
//  Notas
//
//  Created by Antonio de la Torre on 10/3/22.
//

import UIKit
import CoreData

class NotaDetalleVC: UIViewController {
    @IBOutlet weak var tituloTF: UITextField!
    @IBOutlet weak var descTF: UITextView!
    
    var notaSeleccionada: Nota? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        if(notaSeleccionada != nil){
            tituloTF.text = notaSeleccionada?.titulo
            descTF.text = notaSeleccionada?.descripcion
        }
    }

    @IBAction func guardarAction(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        if(notaSeleccionada == nil){

            let entidad = NSEntityDescription.entity(forEntityName: "Nota", in: context)
            let nuevaNota = Nota(entity: entidad!, insertInto: context)
            nuevaNota.id = listanotas.count as NSNumber
            nuevaNota.titulo = tituloTF.text
            nuevaNota.descripcion = descTF.text
            do{
                try context.save()
                listanotas.append(nuevaNota)
                navigationController?.popViewController(animated: true)
                
            }catch{
                print("Error al guardar")
            }
        }else{ //EDITAR
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Nota")
            do{
                let resultados:NSArray = try context.fetch(request) as NSArray
                for resultado in resultados{
                    let nota = resultado as! Nota
                    if(nota == notaSeleccionada){
                        nota.titulo = tituloTF.text
                        nota.descripcion = descTF.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            }catch{
                print("Error al cargar las notas")
            }
        }
        
    }
    @IBAction func BorrarNota(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Nota")
        do{
            let resultados:NSArray = try context.fetch(request) as NSArray
            for resultado in resultados{
                let nota = resultado as! Nota
                if(nota == notaSeleccionada){
                    nota.borradaFecha = Date()
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        }catch{
            print("Error al cargar las notas")
        }
    }
    
}

