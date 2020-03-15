
import Foundation

import SpriteKit
import GameplayKit

class BaseScene: SKScene {

    
    // タップ時の波紋
    var hamonNode : SKShapeNode?
    public func createInitHamonNode(){
        let w : CGFloat = 1.0
        self.hamonNode = SKShapeNode.init(circleOfRadius: w)
        hamonNode?.zPosition = 50
    }
    
    public func makeHamon(_ pos : CGPoint){
        if let n = self.hamonNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.fillColor = .white
            n.strokeColor = .white
            n.name = "spiny"
            self.addChild(n)
//            let to_scale = CGFloat(5 + CommonUtil.rnd(11))
            let to_scale = CGFloat(5 + 6)
            n.run(SKAction.sequence([
                SKAction.scale(to: to_scale, duration: 0.3),
                SKAction.wait(forDuration: 1.0),
                SKAction.fadeOut(withDuration: 0.6),
                SKAction.removeFromParent()]))
        }
    }
    
}
