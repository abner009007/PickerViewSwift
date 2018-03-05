//
//  ViewController.swift
//  PickerViewSwift
//
//  Created by 云中科技 on 2018/3/5.
//  Copyright © 2018年 云中科技. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    fileprivate var cityPickView = ZDYPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        goCityPickerView()
    }

    func goCityPickerView() {
        let model = SCityListModel()
        
        let province1 = SProvinceModel()
        
        let acityModel1 = CityModel()
        acityModel1.Name = "city_Name_a1"
        let acityModel2 = CityModel()
        acityModel2.Name = "city_Name_a2"
        let acityModel3 = CityModel()
        acityModel3.Name = "city_Name_a3"
        province1.Citys = [acityModel1,acityModel2,acityModel3]
        province1.Name = "a"
        
        
        let province2 = SProvinceModel()
        
        let bcityModel1 = CityModel()
        bcityModel1.Name = "city_Name_b1"
        let bcityModel2 = CityModel()
        bcityModel2.Name = "city_Name_b2"
        let bcityModel3 = CityModel()
        bcityModel3.Name = "city_Name_b3"
        province2.Citys = [bcityModel1,bcityModel2,bcityModel3]
        province2.Name = "b"
        
        
        
        let province3 = SProvinceModel()
        
        let ccityModel1 = CityModel()
        ccityModel1.Name = "city_Name_c1"
        let ccityModel2 = CityModel()
        ccityModel2.Name = "city_Name_c2"
        let ccityModel3 = CityModel()
        ccityModel3.Name = "city_Name_c3"
        province3.Citys = [ccityModel1,ccityModel2,ccityModel3]
        province3.Name = "c"
    
        model.provincesList = [province1,province2,province3]
        
        cityPickView.reloadPickerViewDataSource(model: model)
        self.cityPickView.frame = CGRect(x:0,y:0,width:screen_WIDTH,height:screen_HEIGHT);
        self.view.addSubview(self.cityPickView);
        self.cityPickView.selectedCityNameBlock = { cityname,address in
            
            debugPrint("====================",cityname)
            debugPrint("--------------------",address)
        }
        
    }
    
    
    
    
    
}

