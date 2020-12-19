//
//  ViewController.swift
//  ClimaApp
//
//  Created by Mac2 on 27/11/20.
//  Copyright © 2020 Mac2. All rights reserved.
//

import UIKit
import CoreLocation
class ViewController: UIViewController, UITextFieldDelegate, climaManagerDelegate {
    func actualizarClima(clima: virusModelo) {
        DispatchQueue.main.async {
            
        
            self.nombrePais.text = clima.Pais
        self.casosLabel.text = String( "\(clima.Casos) ")
        self.muertesLabel.text = String(  "\(clima.Muertes)")
        self.recuperadosLabel.text = String("\(clima.Recuperados)")
        self.banderaImagen.downloaded(from: clima.Bandera)
        let paisMinuscula =  clima.Pais.lowercased()
            let territorio = "https://geology.com/world/map/map-of-\(paisMinuscula).gif"
            print(territorio)
        self.territorioImagen.downloaded(from: territorio)
        }
    }
    var locationManager = CLLocationManager()
    
    

    var Manager = climaManager()
   
    
    @IBOutlet weak var territorioImagen: UIImageView!
    @IBOutlet weak var banderaImagen: UIImageView!
    @IBOutlet weak var nombrePais: UILabel!
    @IBOutlet weak var muertesLabel: UILabel!
    @IBOutlet weak var recuperadosLabel: UILabel!
    @IBOutlet weak var casosLabel: UILabel!
    @IBOutlet weak var entradaCiudad: UITextField!
    
    
    @IBOutlet weak var tarjetaArriba: UIView!
    @IBOutlet weak var tarjetaAbajo: UIView!
    @IBOutlet weak var tarjetaMedio: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tarjetaArriba.layer.cornerRadius = 10
        tarjetaMedio.layer.cornerRadius = 10
        tarjetaAbajo.layer.cornerRadius = 10
        banderaImagen.layer.cornerRadius = 10
        territorioImagen.layer.cornerRadius = 10
        
        entradaCiudad.delegate=self
        Manager.delegado = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        Manager.fetchClima(nombreCiudad: "Mexico")
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       nombrePais.text = entradaCiudad.text
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if entradaCiudad.text != "" {
            return true}
        else{
            entradaCiudad.placeholder = "Escribe una ciudad"
            return false
        }
    }
    @IBAction func Localizacion(_ sender: UIButton) {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    @IBAction func Buscar(_ sender: UIButton) {
        
        Manager.fetchClima(nombreCiudad: entradaCiudad.text!)
        
    }
    //MARK:- Protocolo
    
    
}//MARK:- Protocolo
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("localizacion")
        if let ubicacion = locations.last{
            let latitud = ubicacion.coordinate.latitude
            let longitud = ubicacion.coordinate.longitude
        
       
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
