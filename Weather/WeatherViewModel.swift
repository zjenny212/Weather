//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Keyi Zhu on 9/11/19.
//  Copyright © 2019 Keyi Zhu. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class WeatherViewModel {
    var weather: [List]?
    var citylist = [4367734]
    var idlist = ["4367734","1796236"]
    var APIkey = "feab5c126469500a7eaf2864c3cb70d6"
    var APIURL = "https://api.openweathermap.org/data/2.5/group?&id=%@&units=metric&appid=%@"
    var City_API = "https://api.openweathermap.org/data/2.5/forecast?id=%@&units=metric&appid=%@"
    var id = ""
    let strObs = BehaviorRelay<[List]>(value: [])
    
    func getWeather() -> Observable<[List]>{
        if citylist.count > 0{
            id = idlist.joined(separator: ",")
        }
        return Observable<[List]>.create({ (obs) -> Disposable in

            let urlstr = String(format: self.APIURL,self.id,self.APIkey)
            print("hell:URL:\(urlstr)")
            let url = URL(string: urlstr)
            let req = URLRequest(url: url!)
            URLSession.shared.rx
                .data(request: req)
                .observeOn(MainScheduler.instance)//execute code in main thread...
                .subscribe(onNext: { data in
                    do{
                        let models = try JSONDecoder().decode(Json4Swift_Base.self, from: data)
                        print("-----------")
                        print(models.list!)
                        //self.strObs.accept(models.list!)
                        obs.onNext(models.list!)
                        obs.onCompleted()
                    }catch{
                        print("error from catch \(error.localizedDescription)")
                    }
                })
            return Disposables.create{
                print("Dispose it")
            }
        })
    }
    //
    func getCityWeather(cityid:String) -> Observable<[List]>{
        return Observable<[List]>.create({ (obs) -> Disposable in
            print(cityid)
            let urlstr = String(format: self.City_API,cityid,self.APIkey)
            print("Detail:URL:\(urlstr)")
            let url = URL(string: urlstr)
            let req = URLRequest(url: url!)
            URLSession.shared.rx
                .data(request: req)
                .observeOn(MainScheduler.instance)//execute code in main thread...
                .subscribe(onNext: { data in
                    do{
                        let models = try JSONDecoder().decode(Json4Swift_Base.self, from: data)
                        print("-----------")
                        print(models.list!)
                        obs.onNext(models.list!)
                        obs.onCompleted()
                    }catch{
                        print("error from catch \(error.localizedDescription)")
                    }
                })
            return Disposables.create{
                print("Dispose it")
            }
        })
    }
    //
    func GetBGColor(icon:String) -> UIColor {
        var backgroundColor:UIColor
        switch icon {
        case "01d"://clear sky
            //backgrounimg.image = UIImage(named: "sunnysky")
         backgroundColor =  #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0.8030019264)
        case "01n","02n":
            backgroundColor =  #colorLiteral(red: 0.08355092257, green: 0.2375026345, blue: 0.4170567989, alpha: 1)
        case "02d"://few clouds
           backgroundColor =  #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)
        case "03d","03n","04d","04n":
            backgroundColor =  #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        case "09d","09n","10d","10n","11d","11n":
            backgroundColor =  #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        default:
            backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        return backgroundColor
    }
    //
    func DateFormatting(dt:Int) ->String{
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "EEEE, MMM d, h:mma"
        
        return dateFormatter.string(from: date)
    }
    //
    func GetFromAPI(){
        APIhandler.shared.getWeather(city: citylist) { (data, error) in
            if error == nil{
                self.weather = data
            }
        }
    }
    func getWeatherinfo()->[List]{
        GetFromAPI()
        return weather!
    }
    func getWeatherCount() -> Int {
        return weather?.count ?? 0
    }
}
