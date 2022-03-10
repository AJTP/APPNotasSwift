//
//  NoteTableView.swift
//  Notas
//
//  Created by Antonio de la Torre on 10/3/22.
//

import UIKit
import CoreData

var listanotas = [Nota]()

class NotaVistaTabla: UITableViewController{
    
    var primeraCarga = true
    
    func notasNoBorradas() -> [Nota]{
        var listaNotasNoBorradas = [Nota]()
        for nota in listanotas{
            if(nota.borradaFecha == nil){
                listaNotasNoBorradas.append(nota)
            }
        }
        
        return listaNotasNoBorradas
    }
    
    override func viewDidLoad() {
        if(primeraCarga){
            primeraCarga=false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Nota")
            do{
                let resultados:NSArray = try context.fetch(request) as NSArray
                for resultado in resultados{
                    let nota = resultado as! Nota
                    listanotas.append(nota)
                }
            }catch{
                print("Error al cargar las notas")
            }
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let notaCelda = tableView.dequeueReusableCell(withIdentifier: "notaCeldaID", for: indexPath) as! NotaCelda
        let estaNota: Nota!
        estaNota = notasNoBorradas()[indexPath.row]
        notaCelda.tituloLabel.text = estaNota.titulo
        notaCelda.descLabel.text = estaNota.descripcion
        
        return notaCelda
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notasNoBorradas().count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editarNota", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editarNota")
        {
            let indexPath = tableView.indexPathForSelectedRow!
            let notaDetalles = segue.destination as? NotaDetalleVC
            
            let notaSeleccionada : Nota!
            notaSeleccionada = notasNoBorradas()[indexPath.row]
            notaDetalles!.notaSeleccionada = notaSeleccionada
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
