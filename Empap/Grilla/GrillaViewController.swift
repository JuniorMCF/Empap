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
        cell.layer.borderWidth = 0.5
        cell.listView.safelyRemoveArrangedSubviews()
        
        if(itemList[indexPath.row].titulo == "Caja"){
            let lista =  itemList[indexPath.row].info as! [Caja]
            let horizontalView = UIStackView()
            horizontalView.axis = .horizontal
            horizontalView.alignment = .center
            horizontalView.distribution = .fillProportionally
            horizontalView.layer.borderWidth = 1
            horizontalView.layer.borderColor = UIColor.black.cgColor
            //colocamos el titulo
            
            
            if(indexPath.row == 0){
                titulosStackView.safelyRemoveArrangedSubviews()
                titulosStackView.axis = .horizontal
                titulosStackView.alignment = .center
                titulosStackView.distribution = .equalSpacing
                titulosStackView.layer.borderWidth = 1
                titulosStackView.layer.borderColor = UIColor.black.cgColor
                addLabelCenter(labeltext: "Fecha    ", stackview: titulosStackView)
                addLabelCenter(labeltext: "Descripcion", stackview: titulosStackView)
                addLabelCenter(labeltext: "Importe", stackview: titulosStackView)
                addLabelCenter(labeltext: "Saldo", stackview: titulosStackView)
            }
            for data in lista{

                addLabel(labeltext: "", text: data.fecha, stackview: horizontalView)
                addLabel(labeltext: "", text: data.descripcion, stackview: horizontalView)
                addLabel(labeltext: "", text: data.debe, stackview: horizontalView)
                addLabel(labeltext: "", text: data.saldo, stackview: horizontalView)
            }
            cell.listView.addArrangedSubview(horizontalView)
            //return cell
            
        }
        if(itemList[indexPath.row].titulo == "Cliente"){
            
            let lista =  itemList[indexPath.row].info as! [Clientes]
            
            
            let horizontalView = UIStackView()
            horizontalView.axis = .horizontal
            horizontalView.alignment = .center
            horizontalView.distribution = .fillProportionally
            horizontalView.layer.borderWidth = 1
            horizontalView.layer.borderColor = UIColor.black.cgColor
            //colocamos el titulo
            
            
            if(indexPath.row == 0){
                titulosStackView.safelyRemoveArrangedSubviews()
                titulosStackView.axis = .horizontal
                titulosStackView.alignment = .center
                titulosStackView.distribution = .equalSpacing
                titulosStackView.layer.borderWidth = 1
                titulosStackView.layer.borderColor = UIColor.black.cgColor
                addLabelCenter(labeltext: "Fecha    ", stackview: titulosStackView)
                addLabelCenter(labeltext: "Comprobante", stackview: titulosStackView)
                addLabelCenter(labeltext: "Importe", stackview: titulosStackView)
                addLabelCenter(labeltext: "Saldo", stackview: titulosStackView)
            }
            
            
            
            
            for data in lista{
               cell.tituloLabel.alpha = 0
         
                    for i in 0 ... posList.count - 1 {
                        if(indexPath.row == posList[i]){
                            cell.tituloLabel.alpha = 1
                            cell.tituloLabel.text = "Cliente: "+data.cliente
                            cell.tituloLabel.backgroundColor = UIColor.green.withAlphaComponent(0.5)
                            cell.tituloLabel.textColor = UIColor.black
                            
                        }
                    }
                
                addLabel(labeltext: "", text: data.fecha, stackview: horizontalView)
                addLabel(labeltext: "", text: data.comprobante, stackview: horizontalView)
                addLabel(labeltext: "", text: data.debe, stackview: horizontalView)
                addLabel(labeltext: "", text: data.saldo, stackview: horizontalView)
            }
            cell.listView.addArrangedSubview(horizontalView)
           
            
        }
        if(itemList[indexPath.row].titulo == "Facturación"){
            let lista =  itemList[indexPath.row].info as! [Facturacion]
            let horizontalView = UIStackView()
            horizontalView.axis = .horizontal
            horizontalView.alignment = .center
            horizontalView.distribution = .fillProportionally
            horizontalView.layer.borderWidth = 1
            horizontalView.layer.borderColor = UIColor.black.cgColor
            //colocamos el titulo
            
            
            if(indexPath.row == 0){
                titulosStackView.safelyRemoveArrangedSubviews()
                titulosStackView.axis = .horizontal
                titulosStackView.alignment = .center
                titulosStackView.distribution = .equalSpacing
                titulosStackView.layer.borderWidth = 1
                titulosStackView.layer.borderColor = UIColor.black.cgColor
                addLabelCenter(labeltext: "Fecha    ", stackview: titulosStackView)
                addLabelCenter(labeltext: "Cliente", stackview: titulosStackView)
                addLabelCenter(labeltext: "Comprobante", stackview: titulosStackView)
                addLabelCenter(labeltext: "Importe", stackview: titulosStackView)
            }
            
            
            
            
            for data in lista{
               addLabel(labeltext: "", text: data.fecha, stackview: horizontalView)
                addLabel(labeltext: "", text: data.cliente, stackview: horizontalView)
                addLabel(labeltext: "", text: data.comprobante, stackview: horizontalView)
                addLabel(labeltext: "", text: data.importe, stackview: horizontalView)
            }
            cell.listView.addArrangedSubview(horizontalView)
            //return cell
           
            
        }
        if(itemList[indexPath.row].titulo == "Pendiente"){
            let lista =  itemList[indexPath.row].info as! [Pendientes]
            let horizontalView = UIStackView()
            horizontalView.axis = .horizontal
            horizontalView.alignment = .center
            horizontalView.distribution = .fillProportionally
            horizontalView.layer.borderWidth = 1
            horizontalView.layer.borderColor = UIColor.black.cgColor
            //colocamos el titulo
            
            
            if(indexPath.row == 0){
                titulosStackView.safelyRemoveArrangedSubviews()
                titulosStackView.axis = .horizontal
                titulosStackView.alignment = .center
                titulosStackView.distribution = .equalSpacing
                titulosStackView.layer.borderWidth = 1
                titulosStackView.layer.borderColor = UIColor.black.cgColor
                addLabelCenter(labeltext: "Fecha    ", stackview: titulosStackView)
                addLabelCenter(labeltext: "Comprobante", stackview: titulosStackView)
                addLabelCenter(labeltext: "Importe", stackview: titulosStackView)
            }
            
            
            
            
            for data in lista{
                addLabel(labeltext: "", text: data.fecha, stackview: horizontalView)
                addLabel(labeltext: "", text: data.comprobante, stackview: horizontalView)
                addLabel(labeltext: "", text: data.importe, stackview: horizontalView)
            }
            cell.listView.addArrangedSubview(horizontalView)
           
            
        }
        
        
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(idOpcion == "1"){
            return CGSize(width: collectionView.frame.width , height: collectionView.frame.height/7 )
        }
        if(idOpcion == "2"){
            return CGSize(width: collectionView.frame.width , height: collectionView.frame.height/7  )
        }
        if(idOpcion == "3"){
            return CGSize(width: collectionView.frame.width , height: collectionView.frame.height/7 )
        }
        if(idOpcion == "4"){
            return CGSize(width: collectionView.frame.width , height: collectionView.frame.height/7  )
        }
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height )
        
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //muestra la data de una celda
        if(idOpcion == "1"){
            let lista =  itemList[indexPath.row].info as! [Caja]
            let horizontalView = UIStackView()
            horizontalView.axis = .vertical
            horizontalView.alignment = .center
            horizontalView.distribution = .fillProportionally
            horizontalView.layer.borderWidth = 1
            horizontalView.layer.borderColor = UIColor.black.cgColor
            for data in lista{
                addLabel(labeltext: "Fecha: ", text: data.fecha, stackview: horizontalView)
                addLabel(labeltext: "Descripción: ", text: data.descripcion, stackview: horizontalView)
                addLabel(labeltext: "Debe:", text: data.debe, stackview: horizontalView)
                addLabel(labeltext: "Importe: ", text: data.haber, stackview: horizontalView)
                addLabel(labeltext: "Saldo: ", text: data.saldo, stackview: horizontalView)
            }
            stackInfoView.addArrangedSubview(horizontalView)
            //ocultamos lo de atras
            GrillaCollectionView.isUserInteractionEnabled = false
            //vistaGeneral.isUserInteractionEnabled = false
            viewTitle.isUserInteractionEnabled = false
            imgLogo.isUserInteractionEnabled = false
            salirButton.isUserInteractionEnabled = false
            volverButton.isUserInteractionEnabled = false
            titulosStackView.isUserInteractionEnabled = false
            GrillaCollectionView.alpha = 0.3
            //vistaGeneral.alpha = 0.5
            salirButton.alpha = 0.3
            volverButton.alpha = 0.3
            imgLogo.alpha = 0.3
            viewTitle.alpha = 0.3
            //vista por delante
            infoView.alpha = 1
            closeInfoView.alpha = 1
            stackInfoView.alpha = 1
            stackInfoView.isUserInteractionEnabled = true
            infoView.isUserInteractionEnabled = true
            closeInfoView.isUserInteractionEnabled = true
        }
        if(idOpcion == "2"){
            let lista =  itemList[indexPath.row].info as! [Clientes]
            let horizontalView = UIStackView()
            horizontalView.axis = .vertical
            horizontalView.alignment = .center
            horizontalView.distribution = .fillProportionally
            horizontalView.layer.borderWidth = 1
            horizontalView.layer.borderColor = UIColor.black.cgColor
            for data in lista{
                addLabel(labeltext: "Cliente: ", text: data.cliente, stackview: horizontalView)
                addLabel(labeltext: "Fecha: ", text: data.fecha, stackview: horizontalView)
                addLabel(labeltext: "Comprobante: ", text: data.comprobante, stackview: horizontalView)
                addLabel(labeltext: "Debe: ", text: data.debe, stackview: horizontalView)
                addLabel(labeltext: "Importe: ", text: data.haber, stackview: horizontalView)
                addLabel(labeltext: "Saldo: ", text: data.saldo, stackview: horizontalView)
            }
            stackInfoView.addArrangedSubview(horizontalView)
            //ocultamos lo de atras
            GrillaCollectionView.isUserInteractionEnabled = false
            //vistaGeneral.isUserInteractionEnabled = false
            viewTitle.isUserInteractionEnabled = false
            viewTitle.isUserInteractionEnabled = false
            imgLogo.isUserInteractionEnabled = false
            salirButton.isUserInteractionEnabled = false
            volverButton.isUserInteractionEnabled = false
            titulosStackView.isUserInteractionEnabled = false
            GrillaCollectionView.alpha = 0.3
            //vistaGeneral.alpha = 0.5
            viewTitle.alpha = 0.3
            salirButton.alpha = 0.3
            volverButton.alpha = 0.3
            imgLogo.alpha = 0.3
            //vista por delante
            infoView.alpha = 1
            closeInfoView.alpha = 1
            stackInfoView.alpha = 1
            stackInfoView.isUserInteractionEnabled = true
            infoView.isUserInteractionEnabled = true
            closeInfoView.isUserInteractionEnabled = true
        }
        if(idOpcion == "3"){
            let lista =  itemList[indexPath.row].info as! [Facturacion]
            let horizontalView = UIStackView()
            horizontalView.axis = .vertical
            horizontalView.alignment = .center
            horizontalView.distribution = .fillProportionally
            horizontalView.layer.borderWidth = 1
            horizontalView.layer.borderColor = UIColor.black.cgColor
            for data in lista{
                addLabel(labeltext: "Fecha: ", text: data.fecha, stackview: horizontalView)
                addLabel(labeltext: "Cliente: ", text: data.cliente, stackview: horizontalView)
                addLabel(labeltext: "Comprobante: ", text: data.comprobante, stackview: horizontalView)
                addLabel(labeltext: "Importe: ", text: data.importe, stackview: horizontalView)
            }
            stackInfoView.addArrangedSubview(horizontalView)
            //ocultamos lo de atras
            GrillaCollectionView.isUserInteractionEnabled = false
            //vistaGeneral.isUserInteractionEnabled = false
            viewTitle.isUserInteractionEnabled = false
            imgLogo.isUserInteractionEnabled = false
            salirButton.isUserInteractionEnabled = false
            volverButton.isUserInteractionEnabled = false
            titulosStackView.isUserInteractionEnabled = false
            GrillaCollectionView.alpha = 0.3
            //vistaGeneral.alpha = 0.5
            salirButton.alpha = 0.3
            volverButton.alpha = 0.3
            imgLogo.alpha = 0.3
            viewTitle.alpha = 0.3
            //vista por delante
            
            infoView.alpha = 1
            closeInfoView.alpha = 1
            stackInfoView.alpha = 1
            stackInfoView.isUserInteractionEnabled = true
            infoView.isUserInteractionEnabled = true
            closeInfoView.isUserInteractionEnabled = true
        }
        if(idOpcion == "4"){
            let lista =  itemList[indexPath.row].info as! [Pendientes]
            let horizontalView = UIStackView()
            horizontalView.axis = .vertical
            horizontalView.alignment = .center
            horizontalView.distribution = .fillProportionally
            horizontalView.layer.borderWidth = 1
            horizontalView.layer.borderColor = UIColor.black.cgColor
            for data in lista{
               addLabel(labeltext: "Fecha: ", text: data.fecha, stackview: horizontalView)
                addLabel(labeltext: "Comprobante: ", text: data.comprobante, stackview: horizontalView)
                addLabel(labeltext: "Importe: ", text: data.importe, stackview: horizontalView)
            }
            stackInfoView.addArrangedSubview(horizontalView)
            //ocultamos lo de atras
            GrillaCollectionView.isUserInteractionEnabled = false
            //vistaGeneral.isUserInteractionEnabled = false
            viewTitle.isUserInteractionEnabled = false
            imgLogo.isUserInteractionEnabled = false
            salirButton.isUserInteractionEnabled = false
            volverButton.isUserInteractionEnabled = false
            titulosStackView.isUserInteractionEnabled = false
            GrillaCollectionView.alpha = 0.3
            //vistaGeneral.alpha = 0.5
            salirButton.alpha = 0.3
            volverButton.alpha = 0.3
            imgLogo.alpha = 0.3
            //vista por delante
            infoView.alpha = 1
            closeInfoView.alpha = 1
            stackInfoView.alpha = 1
            stackInfoView.isUserInteractionEnabled = true
            infoView.isUserInteractionEnabled = true
            closeInfoView.isUserInteractionEnabled = true
            
        }
        
    }
    // funcion para agregar un label al stackview
    func addLabel(labeltext:String,text: String, stackview:UIStackView){
        let label = UILabel(frame: CGRect(x: 0, y: 0, width:100, height: 13))
        label.font = label.font.withSize(14)
        label.textAlignment = NSTextAlignment.center
        label.text = labeltext+text
        label.textColor = UIColor(named: "Color-default")
        stackview.distribution = .fillEqually
        // create the left-side "Donate" view
        stackview.addArrangedSubview(label)
        
    }
    func addLabelLeft(labeltext:String,text: String, stackview:UIStackView){
        let label = UILabel(frame: CGRect(x: 0, y: 0, width:100, height: 13))
        label.textAlignment = NSTextAlignment.left
        label.text = "\(labeltext): "+text
        label.textColor = UIColor.green
        stackview.distribution = .fillProportionally
        // create the left-side "Donate" view
        stackview.addArrangedSubview(label)
        
    }
    func addLabelCenter(labeltext:String, stackview:UIStackView){
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 13))
        
        label.textAlignment = NSTextAlignment.center
        label.text = " \(labeltext)"
        label.textColor = UIColor.white
        stackview.distribution = .fillEqually
        stackview.addArrangedSubview(label)
    }

    var itemList : [Grilla] = []
    var posList : [Int] = []
    var idEmpresa = ""
    var idOpcion = ""
    var clienteTemporal = "" //guarda un cliente para no volver a ponerlo en el titulo
    //vista por encima
    
    @IBOutlet var vistaGeneral: UIView!
    @IBOutlet var infoView: UIView!
    @IBOutlet var closeInfoView: UIButton!
    @IBOutlet var stackInfoView: UIStackView!
    
    @IBAction func tapCloseInfo(_ sender: Any) {
        stackInfoView.safelyRemoveArrangedSubviews()
        infoView.alpha = 0
        closeInfoView.alpha = 0
        stackInfoView.alpha = 0
        stackInfoView.isUserInteractionEnabled = false
        infoView.isUserInteractionEnabled = false
        closeInfoView.isUserInteractionEnabled = false
        
        //volvemos lo demas a su estado activo
         titulosStackView.isUserInteractionEnabled = true
        GrillaCollectionView.isUserInteractionEnabled = true
        vistaGeneral.isUserInteractionEnabled = true
        viewTitle.isUserInteractionEnabled = true
        imgLogo.isUserInteractionEnabled = true
        salirButton.isUserInteractionEnabled = true
        volverButton.isUserInteractionEnabled = true
        GrillaCollectionView.alpha = 1
        viewTitle.alpha = 1
        salirButton.alpha = 1
        volverButton.alpha = 1
        imgLogo.alpha = 1
    }
    @IBOutlet var viewTitle: UIView!
    @IBOutlet var titulosStackView: UIStackView!
    @IBOutlet var imgLogo: UIImageView!
    @IBOutlet var volverButton: UIButton!
    @IBOutlet var salirButton: UIButton!
    @IBOutlet var GrillaCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        infoView.layer.borderWidth = 1
        infoView.layer.borderColor = UIColor.black.cgColor
        infoView.layer.cornerRadius = 10
        infoView.alpha = 0
        closeInfoView.alpha = 0
        stackInfoView.alpha = 0
        stackInfoView.isUserInteractionEnabled = false
        infoView.isUserInteractionEnabled = false
        closeInfoView.isUserInteractionEnabled = false
        
        viewTitle.layer.backgroundColor = UIColor(named: "Color-default")?.cgColor
        viewTitle.layer.borderWidth = 1
        viewTitle.layer.borderColor = UIColor.black.cgColor
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
            print(parameters)
            AF.request(Constants().dominio + Constants().getGrilla, method: .get, parameters: parameters ,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
                              switch response.result{
                                  
                              case.success(let value):
                                           let json = JSON(value)
                                           print(json)

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
                                                        let fecha = self.formatFecha(fecha: value["fecha"].stringValue)
                                                        caja.fecha = fecha
                                                        caja.haber = value["haber"].stringValue
                                                        caja.saldo = value["saldo"].stringValue
                                                        grilla.titulo = "Caja"
                                                        grilla.info.append(caja)
                                                        self.itemList.append(grilla)
                                                    }
                                                    self.GrillaCollectionView.reloadData()
                                                }
                                                
                                                if(self.idOpcion == "2"){
                                                    var def = ""
                                                    var count = 0
                                                    for data in response{
                                                        //print(data)
                                                        let grilla = Grilla()
                                                        let value = JSON(data)
                                                        let clientes = Clientes()
                                                        clientes.idCliente = value["id"].stringValue
                                                        clientes.cliente = value["cliente"].stringValue
                                                        clientes.comprobante = value["comprobante"].stringValue
                                                        clientes.debe = value["debe"].stringValue
                                                        let fecha = self.formatFecha(fecha: value["fecha"].stringValue)
                                                        clientes.fecha = fecha
                                                        clientes.haber = value["haber"].stringValue
                                                        clientes.saldo = value["saldo"].stringValue
                                                        if(def != clientes.cliente){
                                                            def = clientes.cliente
                                                            self.posList.append(count)
                                                        }
                                                        count += 1
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
                                                        let fecha = self.formatFecha(fecha: value["fecha"].stringValue)
                                                        fact.fecha = fecha
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
                                                        let fecha = self.formatFecha(fecha: value["fecha"].stringValue)
                                                        pend.fecha = fecha
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
    func formatFecha(fecha:String)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // This formate is input formated .

        let formateDate = dateFormatter.date(from:fecha)!
        dateFormatter.dateFormat = "dd-MM-yyyy" // Output Formated

        
        return dateFormatter.string(from: formateDate)
        
    }

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
