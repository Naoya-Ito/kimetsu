import Foundation
/*
 * 便利な関数
 */
import Foundation
import SpriteKit
class CommonUtil {
    // 0 から max までの乱数
    class func rnd(_ max : Int) -> Int {
        if(max <= 0){
            return 0
        }
        let rand = Int(arc4random_uniform(UInt32(max)))
        return rand
    }

    // min から range までの乱数
    class func rnd(min: Int, range : Int) -> UInt32 {
        let random = arc4random_uniform(UInt32(range)) + UInt32(min)
        return random
    }
    
    class func rndPos(_ pos : CGPoint, width : Int) -> CGPoint {
        let x = pos.x + CGFloat(-width/2 + CommonUtil.rnd(width))
        let y = pos.y + CGFloat(-width/2 + CommonUtil.rnd(width))
        return CGPoint(x: x, y: y)
    }

    class func distance(from: CGPoint, to : CGPoint) -> CGFloat {
        return CGFloat(hypotf(Float(to.x - from.x), Float(to.y - from.y)))
    }


    // 最低値1の値を返す

    class func valueMin1(_ num : Int) -> Int {
        var value : Int!
    
        if num <= 0 {
            value = 1
        } else {
            value = num
        }
        return value
    }

    class func valueMin0(_ num : Int) -> Int {
        var value : Int!
        if num <= 0 {
            value = 0
        } else {
            value = num
        }
        return value
    }


    // rnd()を２回繰り返す
    // 低いキーの配列ほど出やすくなり、最後の方の配列は出にくくなる
    // 期待値は max の 1/4 か？
    class func minimumRnd(_ max : Int) -> Int {
        if(max <= 0){
            return 0
        }
        return rnd(rnd(max))
    }

    class func delayExec(_ delay : TimeInterval, block:@escaping ()->Void) {
        _ = setTimeout(delay: delay, block: block)
    }

    class func setTimeout(delay:TimeInterval, block:@escaping ()->Void) -> Timer {
        return Timer.scheduledTimer(timeInterval: delay, target: BlockOperation(block: block), selector: #selector(Operation.main), userInfo: nil, repeats: false)
    }

    // **.**% で表示する
    class func getPerString(_ bunsi : Int, _ bunbo : Int) -> String {
        let per = 100.0*Double(bunsi)/Double(bunbo)
        return String(format: "%.2f", per)
    }

    // 16進数で UIColor
    class func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    // 最大文字数をオーバーする場合
    // 省略する範囲を作成する
    class func cutString(str: String, maxLength: Int) -> String {
        if str.count > maxLength {
            let start = str.index(str.startIndex, offsetBy: maxLength)
            let end = str.endIndex
            let range = start..<end
            return str.replacingCharacters(in: range, with: "")
        } else {
            return str
        }
    }

    // 現在の画面のスクリーンショットを取得
    class func screenShot(_ view : UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 1.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let screenShot = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return screenShot
    }

    // per%の確率がヒットしたかどうか
    class func isHitPer(_ per: Int) -> Bool {
        return CommonUtil.rnd(100) < per
    }

    class func getRandomIntByArray(_ list : [Int]) -> Int {
        if list.count == 0 {
            return 0
        }
        return list[rnd(list.count)]
    }

    class func getRandomByArray(_ list : [String]) -> String {
        return list[rnd(list.count)]
    }

    class func getTimeString(_ time_count: Int) -> String {
        var tmp_time = time_count
        let hour = tmp_time/3600
        tmp_time %= 3600
        let minutes = tmp_time/60
        tmp_time %= 60
        let second = tmp_time

        let time_string = String(format: "%02d:%02d:%02d", hour, minutes, second)
        return time_string
    }
}
