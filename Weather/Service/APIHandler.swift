//
//  APIHandler.swift
//  Weather
//
//  Created by Keyi Zhu on 9/11/19.
//  Copyright © 2019 Keyi Zhu. All rights reserved.
//

import Foundation
class APIhandler:NSObject{
    static let shared = APIhandler()
    private override init() {}
    var APIkey = "feab5c126469500a7eaf2864c3cb70d6"
    var APIURL = "http://api.openweathermap.org/data/2.5/group?&id=%@&units=metric&appid=%@"
    var id = ""
    func getWeather(city: [Int], completion:@escaping (_ array:[List]?, _ error:String?)->Void){
        if city.count == 0{
            id = "4887398"
        }
        let urlstr = String(format: APIURL,id,APIkey)
        print(urlstr)
        if let url = URL(string: urlstr){
            URLSession.shared.dataTask(with: url){
                (data,response,error) in
                let res = response as! HTTPURLResponse
                if res.statusCode == 200 && error == nil{
                    do{
                        let dict = try JSONDecoder().decode(Json4Swift_Base.self, from: data!)
                        print(dict.cnt!)
                        completion(dict.list,nil)
                    }catch{
                        print(error)
                        completion(nil,"decode error")
                    }
                }else{
                    completion(nil,"error")
                    print(error?.localizedDescription ?? "error")
                }
            }.resume()
        }
    }//
    
    //
    func getCities(completion:@escaping(_ array:[City]?, _ error:String?)->Void){
        
        guard let cityJsonFile = Bundle.main.path(forResource: "city.list", ofType: "json") else{
            print("city file load error")
            return}
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: cityJsonFile),options: .alwaysMapped)
            let jsonObj = try JSONDecoder().decode([City].self, from: data)
            print(jsonObj.count)
            completion(jsonObj,nil)
            
        }catch{
            print("error")
            completion(nil,"error")
        }
    }
}
