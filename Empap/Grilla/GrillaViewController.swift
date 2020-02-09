//
//  GrillaViewController.swift
//  Empap
//
//  Created by Junior on 2/7/20.
//  Copyright © 2020 EMPAP. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class GrillaViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellIDGrilla", for: indexPath) as! GrillaCollectionViewCell
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.listView.safelyRemoveArrangedSubviews()
        addLabelCenter(labeltext: itemList[indexPath.row].titulo, stackview: cell.listView)
        
        if(itemList[indexPath.row].titulo == "Caja"){
            let lista =  itemList[indexPath.row].info as! [Caja]
            for data in lista{
                
                addLabel(labeltext:"debe: ",text: data.debe, stackview: cell.listView)
                addLabel(labeltext:"descripción: ",text: data.descripcion, stackview: cell.listView)
                addLabel(labeltext:"fecha: ",text: data.fecha, stackview: cell.listView)
                addLabel(labeltext:"haber: ",text: data.haber, stackview: cell.listView)
                addLabel(labeltext:"saldo: ",text: data.saldo, stackview: cell.listView)
            }
            //return cell
            
        }
        if(itemList[indexPath.row].titulo == "Cliente"){
            let lista =  itemList[indexPath.row].info as! [Clientes]
            for data in lista{
                addLabel(labeltext:"cliente: ",text: data.cliente, stackview: cell.listView)
                addLabel(labeltext:"comprobante: ",text: data.comprobante, stackview: cell.listView)
                addLabel(labeltext:"debe: ",text: data.debe, stackview: cell.listView)
                addLabel(labeltext:"fecha: ",text: data.fecha, stackview: cell.listView)
                addLabel(labeltext:"haber: ",text: data.haber, stackview: cell.listView)
                addLabel(labeltext:"saldo: ",text: data.saldo, stackview: cell.listView)
            }
           
            
        }
        if(itemList[indexPath.row].titulo == "Facturación"){
            let lista =  itemList[indexPath.row].info as! [Facturacion]
            for data in lista{
                addLabel(labeltext:"cliente: ",text: data.cliente, stackview: cell.listView)
                addLabel(labeltext:"comprobante: ",text: data.comprobante, stackview: cell.listView)
                addLabel(labeltext:"fecha: ",text: data.fecha, stackview: cell.listView)
                addLabel(labeltext:"importe: ",text: data.importe, stackview: cell.listView)
            }
           
            
        }
        if(itemList[indexPath.row].titulo == "Pendiente"){
            let lista =  itemList[indexPath.row].info as! [Pendientes]
            for data in lista{
                
                addLabel(labeltext:"comprobante: ",text: data.comprobante, stackview: cell.listView)
                addLabel(labeltext:"fecha: ",text: data.fecha, stackview: cell.listView)
                addLabel(labeltext:"importe: ",text: data.importe, stackview: cell.listView)
                
            }
           
            
        }
        
        
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(idOpcion == "1"){
            return CGSize(width: collectionView.frame.width , height: collectionView.frame.height/1.18  )
        }
        if(idOpcion == "2"){
            return CGSize(width: collectionView.frame.width , height: collectionView.frame.height/1.18 )
        }
        if(idOpcion == "3"){
            return CGSize(width: collectionView.frame.width , height: collectionView.frame.height/1.5 )
        }
        if(idOpcion == "4"){
            return CGSize(width: collectionView.frame.width , height: collectionView.frame.height/1.8 )
        }
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height )
        
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //no hace nada :V
    }
    // funcion para agregar un label al stackview
    func addLabel(labeltext:String,text: String, stackview:UIStackView){
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 13))
        label.textAlignment = NSTextAlignment.left
        label.text = " \(labeltext)"+text
        stackview.addArrangedSubview(label)
    }
    func addLabelCenter(labeltext:String, stackview:UIStackView){
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 13))
        label.textAlignment = NSTextAlignment.center
        label.text = " \(labeltext)"
        stackview.addArrangedSubview(label)
    }

    var itemList : [Grilla] = []
    var idEmpresa = ""
    var idOpcion = ""
    
    @IBOutlet var imgLogo: UIImageView!
    @IBOutlet var volverButton: UIButton!
    @IBOutlet var salirButton: UIButton!
    @IBOutlet var GrillaCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imgLogo.frame = CGRect(x:  self.view.frame.width/3 , y: self.view.frame.height/10, width: self.view.frame.width/3, height: self.view.frame.width/3)
        salirButton.backgroundColor = .clear
        salirButton.layer.cornerRadius = 5
        salirButton.layer.borderWidth = 1
        salirButton.layer.borderColor = UIColor.black.cgColor
        
        volverButton.backgroundColor = .clear
        volverButton.layer.cornerRadius = 5
        volverButton.layer.borderWidth = 1
        volverButton.layer.borderColor = UIColor.black.cgColor
        
        
        if(idEmpresa != "" && idOpcion != ""){
            
            let parameters = ["idOpcion":idOpcion, "idEmpresa":idEmpresa]

            AF.request(Constants().dominio + Constants().getGrilla, method: .get, parameters: parameters ,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
                              switch response.result{
                                  
                              case.success(let value):
                                           let json = JSON(value)


                                           let resultado = json["resultado"].stringValue
                                           if(resultado == "200"){
                                              let response = json["response"].arrayValue
                                                
                                                if(self.idOpcion == "1"){
                                                    for data in response{
                                                        let grilla = Grilla()
                                                        let value = JSON(data)
                                                        let caja = Caja()
                                                        caja.idCaja = value["id"].stringValue
                                                        caja.debe = value["debe"].stringValue
                                                        caja.descripcion = value["descripcion"].stringValue
                                                        caja.fecha = value["fecha"].stringValue
                                                        caja.haber = value["haber"].stringValue
                                                        caja.saldo = value["saldo"].stringValue
                                                        grilla.titulo = "Caja"
                                                        grilla.info.append(caja)
                                                        self.itemList.append(grilla)
                                                    }
                                                    self.GrillaCollectionView.reloadData()
                                                }
                                                
                                                if(self.idOpcion == "2"){
                                                    for data in response{
                                                        let grilla = Grilla()
                                                        let value = JSON(data)
                                                        let clientes = Clientes()
                                                        clientes.idCliente = value["id"].stringValue
                                                        clientes.cliente = value["cliente"].stringValue
                                                        clientes.comprobante = value["comprobante"].stringValue
                                                        clientes.debe = value["debe"].stringValue
                                                        clientes.fecha = value["fecha"].stringValue
                                                        clientes.haber = value["haber"].stringValue
                                                        clientes.saldo = value["saldo"].stringValue
                                                        
                                                        grilla.titulo = "Cliente"
                                                        grilla.info.append(clientes)
                                                        self.itemList.append(grilla)
                                                    }
                                                    self.GrillaCollectionView.reloadData()
                                                }
                                                        
                                                if(self.idOpcion == "3"){
                                                    for data in response{
                                                        let grilla = Grilla()
                                                        let value = JSON(data)
                                                        let fact = Facturacion()
                                                        fact.idFacturacion = value["id"].stringValue
                                                        fact.cliente = value["cliente"].stringValue
                                                        fact.comprobante = value["comprobante"].stringValue
                                                        fact.fecha = value["fecha"].stringValue
                                                        fact.importe = value["importe"].stringValue
                                                    
                                                        grilla.titulo = "Facturación"
                                                        grilla.info.append(fact)
                                                        self.itemList.append(grilla)
                                                    }
                                                    self.GrillaCollectionView.reloadData()
                                                }
                                                
                                                if(self.idOpcion == "4"){
                                                    
                                                    for data in response{
                                                        let grilla = Grilla()
                                                        let value = JSON(data)
                                                        let pend = Pendientes()
                                                        pend.idPendiente = value["id"].stringValue
                                                        pend.comprobante = value["comprobante"].stringValue
                                                        pend.fecha = value["fecha"].stringValue
                                                        pend.importe = value["importe"].stringValue
                                                        
                                                        grilla.titulo = "Pendiente"
                                                        grilla.info.append(pend)
                                                        self.itemList.append(grilla)
                                                    }
                                                    self.GrillaCollectionView.reloadData()
                                                }

                                           }else if (resultado == "201")  {
                                               //vacio
                                           }else if (resultado == "404"){
                                               //fallo en la consulta GET
                                           }

                                                   
                                               
                                         break
                                      case.failure(let error):
                                          print(error)
                                          break
                                  }
                  }
            
        }else{
            //no se obtuvo los datos en el intent
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapBackLogin(_ sender: Any) {
        
        let alert = UIAlertController(title: "Salir", message: "Cerrar sesión", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Si", style: .default, handler: { action in
            Constants().saveLogin(isLogin: false)
            Constants().saveUsername(username: "")
            Constants().savePassword(password: "")
            Constants().saveIdUser(id: "")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "LoginID")
            self.navigationController?.pushViewController(viewController, animated: false)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
        
        
    }
    @IBAction func onBackPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MenuID") as! MenuViewController
        viewController.idEmpresa = idEmpresa
        self.navigationController?.popViewController(animated: true )
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIStackView {

    func safelyRemoveArrangedSubviews() {

        // Remove all the arranged subviews and save them to an array
        let removedSubviews = arrangedSubviews.reduce([]) { (sum, next) -> [UIView] in
            self.removeArrangedSubview(next)
            return sum + [next]
        }

        // Deactive all constraints at once
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))

        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
