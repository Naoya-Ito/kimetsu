// ストーリーに関するクラス
import Foundation
import UIKit
class Story {
    public var page = 0
    
    public var left_image : String = ""
    public var right_image : String = ""
    public var left_xscale : CGFloat = 1.0
    public var right_xscale : CGFloat = 1.0
    public var next_key = ""

    public var data_array : NSArray?
    public var talker : String = "left"
    
    public var text1 = ""
    public var text2 = ""
    public var text3 = ""
    
    init(_ key : String) {
        let dataPath = Bundle.main.path(forResource: "stories", ofType:"plist" )!
        let tmp_dictionary = NSDictionary(contentsOfFile: dataPath)!
        data_array = tmp_dictionary.object(forKey: key) as? NSArray
        if data_array == nil {
            print("Error. can't read story dictionary.key=\(key)")
            return
        }
        
        loadDataByList()
    }
    
    public func loadNextPage(){
        page += 1
        print("now page=\(page)")
        if data_array!.count  <= page {
            print("max_page=\(data_array!.count). now_page=\(page)")
            return
        }
        
        loadDataByList()
        print("load comp")
    }
    
    private func loadDataByList(){
        print("load data. page=\(page)")
        let list = data_array![page] as? NSDictionary
        if list == nil {
            print("error. story page=\(page) is not exist.")
        }
        right_image   = list!["right_image"] as? String ?? "kappa"
        right_xscale  = list!["right_xscale"] as? CGFloat ?? 1.0
        left_image    = list!["left_image"] as? String ?? "kappa"
        left_xscale   = list!["left_xscale"] as? CGFloat ?? 1.0
        talker        = list!["talker"] as? String ?? "left"
        text1         = list!["text1"] as? String ?? ""
        text2         = list!["text2"] as? String ?? ""
        text3         = list!["text3"] as? String ?? ""
        next_key      = list!["next_key"] as? String ?? ""
        
        print("load data by list comp")
    }
}
