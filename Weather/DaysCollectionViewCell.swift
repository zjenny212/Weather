//
//  DaysCollectionViewCell.swift
//  Weather
//
//  Created by Keyi Zhu on 9/12/19.
//  Copyright © 2019 Keyi Zhu. All rights reserved.
//

import UIKit

class DaysCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cloud: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var tempHigh: UILabel!
    @IBOutlet weak var tempLow: UILabel!
    @IBOutlet weak var dateInfo: UILabel!
    
    func setupview(icon:String){
        weatherIcon.image = UIImage(named: icon)
    }
}
