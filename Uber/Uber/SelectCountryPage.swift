//
//  SelectCountryPage.swift
//  Uber
//
//  Created by 小儿黑挖土 on 2017/2/18.
//  Copyright © 2017年 小儿黑挖土. All rights reserved.
//

import UIKit
protocol SelectCountryPageDelegate {
    func didSelectCountry(code:String)
}

class SelectCountryPage: BasePage,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var tableView:UITableView!
    var countrys:[CountryInfo]?
    var heads:[String]?
    var dicDatas:[String:AnyObject]?
    var delegate:SelectCountryPageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "选择国家/地区"
        setNavigationItem(title: "返回", selector: #selector(doBack), isRight: false)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        initCountrys()
        initDicDatas()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellID")
        tableView.reloadData()
        
//        let testStr = "中国"
//        let testLetter = getFirstCharFromString(str: testStr)
//        print("testStr is \(testLetter)")
    }
    override func doBack() {
        self.navigationController?.popViewController(animated: true)
    }
//    MARK: -SelectCountryDelegate
    //MARK:-private
    func initCountrys(){
        let codes = NSLocale.isoCountryCodes
        let locale = NSLocale.current as NSLocale
        var info:CountryInfo!
        countrys = []
        for code in codes{
            info = CountryInfo()
            info.code = code
            info.name = locale.displayName(forKey: NSLocale.Key.countryCode, value: code)
            countrys?.append(info)
        }
        countrys?.sort(by: {
            (arg1:CountryInfo, arg2:CountryInfo) -> Bool in
            return arg1.name.localizedCaseInsensitiveCompare(arg2.name) == .orderedAscending
            
        })
    }
    func initDicDatas(){
        heads = []
        dicDatas = [:]
        var dataArr:[CountryInfo]! = []
        for info in countrys!{
            let letter = getFirstCharFromString(str: info.name)
            if !(heads!.contains(letter)){
                if dataArr.count>0{
                    dicDatas?[(heads?.last)!] = dataArr as AnyObject?
                }
                heads?.append(letter)
                dataArr = []
            }
            dataArr.append(info)
        }
        dicDatas?[(heads?.last)!] = dataArr as AnyObject?
        
        
    }
    func characterToInt(char:Character)->Int{
        /*
         for scalar in String(characterB).unicodeScalars
         {
         //字符串只有一个字符，这个循环只会执行1次
         numberFromB = Int(scalar.value)
         }
         */
        var aInt:Int?
        for scalar in String(char).unicodeScalars{
            aInt = Int(scalar.value)
        }
        return aInt!
    }
    //MARK:-tableViewDelegate&&datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return (heads?.count)!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key:String = heads![section]
        let countrys:[CountryInfo] = dicDatas![key] as! [CountryInfo]
        return countrys.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return heads?[section]
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        let key = heads![indexPath.section]
        let countrys:[CountryInfo] = dicDatas![key] as! [CountryInfo]
        let info = countrys[indexPath.row]
        cell.textLabel?.text = info.name
        return cell
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var indexs:[String]=[]
        var char:[CChar]=[0,0]
        
        for i in 65 ..< 65+26 {
            char[0] = CChar(i)
            indexs.append(String.init(cString: char))
        }
        indexs.append("#")
        
        return indexs
    }
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        var curIndex:Int!
        if title == "#"{
            return 0
        }else{
//            let charArr:[CChar] = title.cString(using: String.Encoding.utf8)!
//            let char = charArr[0]
//            var charArr:[Character]?
//            for char in title.characters{
//                charArr?.append(char)
//            }
//            let firstChar = Character(title)
//            let aChar = Character("A")
//            curIndex = characterToInt(char: firstChar) - characterToInt(char: aChar)
//            
//            let offSetY = getHeight(index: curIndex!)
//            if(offSetY == tableView.contentOffset.y){
//                return index
//            }else{
//                tableView.contentOffset = CGPoint(x: 0, y: offSetY)
//            }
//            return NSNotFound
            let firstChar = Character(title)
            let aChar = Character("A")
            
            curIndex = characterToInt(char: firstChar) - characterToInt(char: aChar)
            if(curIndex<8){
                return curIndex
            }else if(curIndex == 8){
                return NSNotFound
            }else if(curIndex<14){
                return curIndex-1
            }else if(curIndex == 14){
                return NSNotFound
            }else if(curIndex<16){
                return curIndex-2
            }else if(curIndex == 16){
                return NSNotFound
            }else if(curIndex<20){
                return curIndex-3
            }else if(curIndex<22){
                return NSNotFound
            }else{
                return curIndex-5
            }
        }
    }
    func getHeight(index:Int)->CGFloat{
        var countInSetion:Int = 0
        var headCount = index
//        var array:[Int:Int] = [:]
        if index == 0{
            return -64
        }else{
            for i in 0..<index{
//                print("heads count is \(heads?.count)")
//                print("head is \(heads)")
                if(i==9||i==15||i==17||i==21||i==22){
                    headCount -= 1
                    continue
                }else{
                    let key = heads![i]
                    let countyArr = dicDatas![key] as! [CountryInfo]
                    countInSetion += countyArr.count
                }
            }
            return CGFloat(countInSetion*44)+CGFloat(index*28)-64
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = heads![indexPath.section]
        let countryArr:[CountryInfo] = dicDatas![key] as! [CountryInfo]
        let selectCountry = countryArr[indexPath.row]
        delegate?.didSelectCountry(code: selectCountry.code)
        doBack()
    }
}
