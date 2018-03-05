//
//  ZDYDataPicker.swift

//
//  Created by 云中科技 on 2017/11/9.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

let screen_WIDTH : CGFloat          = UIScreen.main.bounds.size.width
let screen_HEIGHT : CGFloat         = UIScreen.main.bounds.size.height
let baseFont                        = UIFont.systemFont(ofSize: 14);
let baseColor_main_blue         = UIColor.blue
let baseColor_backgroundColor   = UIColor.groupTableViewBackground


class ZDYPickerView: UIView ,UIPickerViewDelegate, UIPickerViewDataSource{
    
    var selectedCityNameBlock:((_ cityname:String,_ address:String) ->Void)?
    
    var title = UILabel()
    var cancelButton = UIButton();
    var confirmButton = UIButton();
    
    var backgrouend = UIView()
    var backgrouendViewBlack = UIView()
    var lineView = UIView()
    var pickerView = UIPickerView()
    var cityListModel = SCityListModel();
    var selectedLeftTableViewRow = 0;
    var selectedRightTableViewRow = 0;

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupUI();
    }
    
    //在吊起view之前必须传入城市列表的model
    func reloadPickerViewDataSource(model:SCityListModel) {
        
        cityListModel = model;
        pickerView.reloadAllComponents();
    }
    
    //MARK:按钮的点击
    func buttonClick(_ sender:UIButton) {
        
        switch sender.tag {
        case 101:
            self.removeFromSuperview();
        case 102:
            let model = cityListModel.provincesList?[selectedLeftTableViewRow];
            let cityModel = model?.Citys?[selectedRightTableViewRow];
            
            if selectedCityNameBlock != nil {
                selectedCityNameBlock!((cityModel?.Name)!,(model?.Name)!+(cityModel?.Name)!);
                self.removeFromSuperview();
            }
        default:
            break
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        if component==0
        {
            selectedLeftTableViewRow = row;
            selectedRightTableViewRow = 0;
            pickerView.reloadComponent(1);
            pickerView.selectRow(0, inComponent: 1, animated: true);
        }
        else
        {
            selectedRightTableViewRow = row;
        }
    }
    //设置选择框的列数为3列,继承于UIPickerViewDataSource协议
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    //设置选择框的行数
    func pickerView(_ pickerView: UIPickerView,numberOfRowsInComponent component: Int) -> Int {
        
        let model = self.cityListModel.provincesList?[self.selectedLeftTableViewRow];
        return component==0 ? (self.cityListModel.provincesList?.count)! : (model?.Citys?.count)!;
    }
    //设置列宽
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        
        return 0 == component ? screen_WIDTH*0.5-50 : screen_WIDTH*0.5+50;
    }
    //设置行高
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    //设置选择框各选项的内容，继承于UIPickerViewDelegate协议
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,forComponent component: Int) -> String? {
        
        if component==0
        {
            let model = self.cityListModel.provincesList?[row];
            return model?.Name;
        }
        else
        {
            let model = self.cityListModel.provincesList?[self.selectedLeftTableViewRow];
            let cityModel = model?.Citys?[row];
            return cityModel?.Name;
        }
    }
    //自定义视图  使用的时候  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,forComponent component: Int) -> String? {} 不再有效
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView  
    {  
        // 每个选择框每行自定义视图  
        let width = 0 == component ? screen_WIDTH*0.5-50 : screen_WIDTH*0.5+50;
        
        let titleLabel = UILabel(frame: CGRect(x:0.0, y:0.0, width:width, height:44));  
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.font = baseFont;
        titleLabel.textAlignment = NSTextAlignment.center;  
        
        if component==0
        {
            let model = self.cityListModel.provincesList?[row];
            titleLabel.text = model?.Name;
        }
        else
        {
            let model = self.cityListModel.provincesList?[self.selectedLeftTableViewRow];
            let cityModel = model?.Citys?[row];
            titleLabel.text = cityModel?.Name;
        } 
        
        return titleLabel  
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let view = touches.first?.view;
        if view == self.backgrouendViewBlack
        {
            self.removeFromSuperview();
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        cancelButton.frame = CGRect(x:0,y:5,width:40,height:30);
        confirmButton.frame = CGRect(x:screen_WIDTH-40,y:5,width:40,height:30);
        title.frame = CGRect(x:40,y:10,width:screen_WIDTH-80,height:20);
        lineView.frame = CGRect(x:0,y:39,width:screen_WIDTH,height:1);
        pickerView.frame = CGRect(x:0,y:40,width:screen_WIDTH,height:216);
    }
    func setupUI() {
        
        self.backgroundColor = UIColor.clear;
        
        backgrouendViewBlack.frame = CGRect(x:0,y:0,width:screen_WIDTH,height:screen_HEIGHT);
        backgrouendViewBlack.backgroundColor = UIColor.black;
        backgrouendViewBlack.alpha = 0.5;
        self.addSubview(backgrouendViewBlack);
        
        backgrouend = UIView.init(frame: CGRect(x:0,y:screen_HEIGHT-256,width:screen_WIDTH,height:256));
        backgrouend.backgroundColor = UIColor.white;
        self.addSubview(backgrouend);
        
        self.title.textColor = baseColor_main_blue
        self.title.textAlignment = .center
        self.title.font = baseFont
        self.title.text = "选择城市";
        self.backgrouend.addSubview(title)
        
        self.cancelButton.setTitle("取消", for: .normal);
        self.cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        self.cancelButton.backgroundColor = UIColor.clear;
        self.cancelButton.setTitleColor(UIColor.black, for: .normal)
        self.cancelButton.tag = 101
        self.cancelButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        self.backgrouend.addSubview(cancelButton)
        
        self.lineView.backgroundColor = baseColor_backgroundColor
        self.backgrouend.addSubview(self.lineView)
        
        self.confirmButton.setTitle("确定", for: .normal);
        self.confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        self.confirmButton.backgroundColor = UIColor.clear;
        self.confirmButton.setTitleColor(UIColor.black, for: .normal)
        self.confirmButton.tag = 102
        self.confirmButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        self.backgrouend.addSubview(confirmButton)
        
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.backgrouend.addSubview(pickerView)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
