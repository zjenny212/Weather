//
//  CityTableViewCell.swift
//  Weather
//
//  Created by Keyi Zhu on 9/11/19.
//  Copyright © 2019 Keyi Zhu. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    @IBOutlet weak var cityname: UILabel!
    @IBOutlet weak var tempHigh: UILabel!
    @IBOutlet weak var tempLo: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var backgrounimg: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
                //let padding = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        layoutMargins = UIEdgeInsets.zero
                contentView.layoutMargins.bottom = 20
        
    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        let padding = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
//        bounds = bounds.inset(by: padding)
//    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func BackgroundColor(icon:String){
        let urlraw = "http://openweathermap.org/img/wn/%@@2x.png"
        let urlstr = String(format: urlraw, icon)
        let url = URL(string: urlstr)
        let imgData = try? Data(contentsOf: url!)
        weatherImg.image = UIImage(data: imgData!)
        
        switch icon {
        case "01d"://clear sky
            backgrounimg.image = UIImage(named: "sunnysky")
           // self.backgroundColor =  #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0.8030019264)
        case "01n","02n":
            //self.backgroundColor =  #colorLiteral(red: 0.08355092257, green: 0.2375026345, blue: 0.4170567989, alpha: 1)
            backgrounimg.image = UIImage(named: "nightsky")
        case "02d"://few clouds
            self.backgroundColor =  #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)
        case "03d","03n","04d","04n":
            self.backgroundColor =  #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        case "09d","09n","10d","10n","11d","11n":
            self.backgroundColor =  #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        default:
            self.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
}
