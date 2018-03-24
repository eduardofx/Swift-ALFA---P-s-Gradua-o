//
//  TbPessoa.swift
//  Aula2
//
//  Created by Faculdade Alfa on 24/03/2018.
//  Copyright © 2018 Faculdade Alfa. All rights reserved.
//

import UIKit
import CoreData

class TbPessoa {
    
    private let nomeTabela = "TblPessoa"
    private var pessoas:[NSManagedObject] = []

    func buscar(filtro: NSPredicate?) -> [Pessoa] {
        pessoas = []
        var listaPessoa = [Pessoa]()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
             return listaPessoa
        }
        
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSManagedObject> (entityName: nomeTabela)
        
        do {
            if let condicao = filtro {
                fetchRequest.predicate = condicao
            }
            
            pessoas = try managedContext.fetch(fetchRequest)
        }
        catch let error as NSError{
            print("Deu Erro: \(error) .  \(error.userInfo)")
        }
        
        for registro in pessoas{
            let nome   = registro.value(forKey: "nome") as! String
            let cidade = registro.value(forKey: "cidade") as! String
            let pes = Pessoa(nome: nome, cidade: cidade)
            
            listaPessoa.append(pes)
        }
        
        return listaPessoa
    }
    
    func salvar(i: Int, nome: String, cidade: String) {
        if (i >= 0){
            alterar(i: i, nome: nome, cidade: cidade)
        }else{
            inserir(nome: nome, cidade: cidade)
        }
    }
    
    private func inserir(nome: String, cidade: String){
        
    }
    
    private func alterar(i: Int, nome: String, cidade: String){
        
    }
    
    func deletar(i: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let managedContext = appDelegate.managedObjectContext
        managedContext.delete(self.pessoas[i])
    }
}

