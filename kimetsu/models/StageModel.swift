// ステージに関するクラス
import Foundation
import UIKit
class Stage {
    public var floor = 0
    public var max_floor : Int
    public var enemies : [String]
    
    private var list : NSDictionary?
    
    init(_ key : String) {
        let dataPath = Bundle.main.path(forResource: "stages", ofType:"plist" )!
        let plist_data = NSDictionary(contentsOfFile: dataPath)!
        list = plist_data.object(forKey: key) as? NSDictionary
        if list == nil {
            print("Error. can't read stage dictionary.key=\(key)")
        }
        max_floor     = list!["floor"] as? Int ?? 5
        enemies       = list!["enemies"] as? [String] ?? ["tanuki"]
        

    }
    
}
