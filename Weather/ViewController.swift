//
//  ViewController.swift
//  Weather
//
//  Created by Keyi Zhu on 9/11/19.
//  Copyright © 2019 Keyi Zhu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class ViewController: UIViewController {

    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var isloading: UIActivityIndicatorView!
    let bag = DisposeBag()
    var weather: [List]?
    var citylist = [4367734]
    override func viewDidLoad() {
        super.viewDidLoad()
        isloading.hidesWhenStopped = true
        isloading.center = view.center
        isloading.startAnimating()
        setupTableview()
        isloading.stopAnimating()
    }
    func setupTableview(){
        WeatherViewModel().getWeather().bind(to: tbView.rx.items(cellIdentifier: "cell", cellType: CityTableViewCell.self)){
        (index, model, cell) in
            cell.cityname.text = model.name
            cell.tempHigh.text = "\(String(format: "%.1f",model.main?.temp_max ?? 0))°C"
            cell.tempLo.text = "\(String(format: "%.1f",model.main?.temp_min ?? 0))°C"
            cell.BackgroundColor(icon: model.weather![0].icon!)
            print("---------")
            //
        }.disposed(by: bag)
        //tbview.rx.modelSelected(Person.self).subscribe(onNext:{
            //            val in
            //            print("Selected row value: \(val.name)")
            //        }).disposed(by: bag)
        tbView.rx.modelSelected(List.self).subscribe(onNext:{
            val in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            vc.selected = val
            vc.city = String(val.id!)
            self.present(vc,animated: true)
        }).disposed(by: bag)
    
    }
    @IBAction func AddBtnAction( _ sender: Any){
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddCityViewController") as! AddCityViewController
        present(vc,animated: true)
    }
    
}

