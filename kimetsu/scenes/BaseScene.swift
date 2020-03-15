import Foundation
import SpriteKit
import GameplayKit

class BaseScene: SKScene {

    public var lastUpdateTime : TimeInterval = 0
    override func sceneDidLoad() {
        commonSceneDidLoad()
    }
    
    public func commonSceneDidLoad(){
        createInitHamonNode()
        self.lastUpdateTime = 0
    }
    
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
    
    
    func touchDown(atPoint pos : CGPoint) {
        makeHamon(pos)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
}
