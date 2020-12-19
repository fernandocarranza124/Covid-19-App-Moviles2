//
//  climaManager.swift
//  ClimaApp
//
//  Created by Mac2 on 27/11/20.
//  Copyright © 2020 Mac2. All rights reserved.
//

import Foundation
protocol climaManagerDelegate {
    func actualizarClima(clima: virusModelo)
}
struct climaManager {
    var delegado: climaManagerDelegate?
    
    
      var url="https://corona.lmao.ninja/v3/covid-19/countries"
    func fetchClima(nombreCiudad: String){
        let urlAtributos = "\(url)/\(nombreCiudad)"
        
        realizarPeticion(urlString: urlAtributos)
    }
    
    func realizarPeticion(urlString: String) {
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let tarea = session.dataTask(with: url) { (data,respuesta,error) in
                if error != nil {
                    return
                }
                if let datosSeguros = data {
                    if let clima = self.parseJson(climadata: datosSeguros){
                        self.delegado?.actualizarClima(clima: clima)
                        
                    }
                }
            }
            
            
            
            tarea.resume()
        }
        
    }
    func parseJson(climadata: Data) -> virusModelo? {
        let decoder = JSONDecoder()
        
        do{
            let dataDecodificada = try decoder.decode(virusData.self, from: climadata)
            let nombre = dataDecodificada.country
            let casos = dataDecodificada.cases
            let muertes = dataDecodificada.deaths
            let recuperados = dataDecodificada.recovered
            let poblacion = dataDecodificada.population
            let bandera = dataDecodificada.countryInfo.flag
                
            let ObjVirus = virusModelo(Pais: nombre, Casos: casos, Muertes: muertes, Recuperados: recuperados, Poblacion: poblacion, Bandera: bandera)
            
            
            return ObjVirus
            
        }catch{
            print (error)
            return nil
        }
    }
    
    func handle(data: Data?, respuesta: URLResponse?, error: Error? ){
        if error != nil{
            return
        }
        if let datosSeguros = data {
            let dataString = String(data: datosSeguros, encoding: .utf8)
        }
        
    }
}
