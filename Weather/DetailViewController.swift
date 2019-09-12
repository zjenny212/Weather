//
//  DetailViewController.swift
//  Weather
//
//  Created by Keyi Zhu on 9/11/19.
//  Copyright © 2019 Keyi Zhu. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class DetailViewController: UIViewController {
    @IBOutlet weak var CityName: UILabel!
    @IBOutlet weak var dateTxt: UILabel!
    @IBOutlet weak var summaryTxt: UILabel!
    
    
    
    var viewModel = WeatherViewModel()
    var city:String?
    var selected:List?
    let bag = DisposeBag()
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCurrentCity()
        setupCollectionView()
    }
    func setupCurrentCity(){
        CityName.text = selected?.name
        dateTxt.text = viewModel.DateFormatting(dt: (selected?.dt)!)
        summaryTxt.text = selected?.weather?.first?.description
        self.view.backgroundColor = viewModel.GetBGColor(icon: (selected?.weather?.first!.icon)!)
    }
    func setupCollectionView(){
        viewModel.getCityWeather(cityid: city!).bind(to: collectionView.rx.items(cellIdentifier: "colcell", cellType: DaysCollectionViewCell.self)){
            (index, model, cell) in
            cell.cloud.text = "Could: \(model.clouds?.all ?? 0) %"
            cell.humidity.text = "Humidity:\(model.main?.humidity ?? 0) %"
            cell.wind.text = "Wind: \(model.wind?.speed ?? 0) m/s"
            cell.tempHigh.text = "\(String(format: "%.1f",model.main?.temp_max ?? 0))°C"
            cell.tempLow.text = "\(String(format: "%.1f",model.main?.temp_min ?? 0))°C"
            cell.dateInfo.text = self.viewModel.DateFormatting(dt: model.dt!)
            cell.setupview(icon: model.weather![0].icon!)
            //
            }.disposed(by: bag)
    }
    @IBAction func GoBackAction(_ sender: UIButton) {
       self.dismiss(animated: true, completion: nil)
    }
    
}
