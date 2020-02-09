//
//  Constants.swift
//  Empap
//
//  Created by Junior on 2/7/20.
//  Copyright © 2020 EMPAP. All rights reserved.
//

import Foundation

class Constants{
    
    var dominio = "https://empap.000webhostapp.com/backend/"
    
    var postLogin = "Login.php"
    
    var getEmpresas = "Empresas.php"
    var getMenu = "Menu.php"
    var getGrilla = "Grilla.php"
    
    //Shared Preferences
    var preferences : UserDefaults? = nil
    func getPreference() -> UserDefaults{
        if(preferences == nil){
            preferences = UserDefaults.standard
        }
        return preferences!
    }
    
    //object saves
    func saveUsername(username:String){
        getPreference().set(username,forKey:"username")
        getPreference().synchronize()
    }
    func getUsername()->String{
        return getPreference().object(forKey:"username" ) as! String
    }
    func savePassword(password:String){
        getPreference().set(password,forKey:"password")
        getPreference().synchronize()
    }
    func getPassword()->String{
        return getPreference().object(forKey:"password" ) as! String
    }
    
    func saveLogin(isLogin:Bool){
        getPreference().set(isLogin,forKey:"isLogin")
        getPreference().synchronize()
    }
    func getLogin()->Bool{
        return getPreference().object(forKey:"isLogin" ) as? Bool ?? false
    }
    func saveIdUser(id:String){
        getPreference().set(id,forKey:"idUser")
        getPreference().synchronize()
    }
    func getIdUser()->String{
        return getPreference().object(forKey: "idUser") as! String
    }
    
}
