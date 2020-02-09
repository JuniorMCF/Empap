//
//  MenuViewController.swift
//  Empap
//
//  Created by Junior on 2/7/20.
//  Copyright © 2020 EMPAP. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MenuViewController: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellIDMenu", for: indexPath) as! MenuCollectionViewCell
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.menuLabel.text = itemList[indexPath.row].nombreMenu
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.width / 6 )
        
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "GrillaID") as! GrillaViewController
        viewController.idEmpresa = idEmpresa
        viewController.idOpcion = itemList[indexPath.row].id
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    var itemList : [Menu] = []
    //se recibe por un intent desde EmpresasViewController
    var idEmpresa = ""
    
    @IBOutlet var imgLogo: UIImageView!
    @IBOutlet var MenuCollectionView: UICollectionView!
    @IBOutlet var volverButton: UIButton!
    @IBOutlet var salirButton: UIButton!
    
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
        
        
        AF.request(Constants().dominio + Constants().getMenu, method: .get, parameters: nil,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
                          switch response.result{
                              
                          case.success(let value):
                                       let json = JSON(value)
                                       

                                       let resultado = json["resultado"].stringValue
                                       if(resultado == "200"){
                                          let response = json["response"].arrayValue
                                          
                                          
                                          for data in response{
                                              
                                              let value = JSON(data)
                                              let menu = Menu()
                                              menu.id = value["id"].stringValue
                                              menu.nombreMenu = value["nombre"].stringValue
                                              self.itemList.append(menu)
                                          }
                                          self.MenuCollectionView.reloadData()
        
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
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let viewController = storyboard.instantiateViewController(withIdentifier: "EmpresasID")
        
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
