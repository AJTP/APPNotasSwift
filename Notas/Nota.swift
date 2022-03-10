//
//  Nota.swift
//  Notas
//
//  Created by Antonio de la Torre on 10/3/22.
//

import CoreData

@objc(Nota)
class Nota:NSManagedObject{
    @NSManaged var id: NSNumber!
    @NSManaged var titulo: String!
    @NSManaged var descripcion: String!
    @NSManaged var borradaFecha: Date?
}
