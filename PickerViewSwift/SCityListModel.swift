//
//  DATProvince.swift

//
//  Created by 云中科技 on 2017/10/23.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class SCityListModel: NSObject {
    
    var provincesList : [SProvinceModel]? = []
}

class SProvinceModel: NSObject {
    
    var Citys : [CityModel]? = []
    
    var Id: String?
    var Name: String?
}
class CityModel: NSObject {
    
    
    var Id: String?
    var Name: String?
    var ProvinceId: String?
}
