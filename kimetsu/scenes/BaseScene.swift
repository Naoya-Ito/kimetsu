import Foundation
import SpriteKit
import GameplayKit

class BaseScene: SKScene, SKPhysicsContactDelegate {

    public var lastUpdateTime : TimeInterval = 0
    public var onceFlag = false
    public var kappa : KappaNode = KappaNode()

    override func sceneDidLoad() {
        commonSceneDidLoad()
    }
    
    public func commonSceneDidLoad(){
        createInitHamonNode()
        self.lastUpdateTime = 0
    }
    
    public func setKappa(){
        kappa = self.childNode(withName: "//kappa") as! KappaNode
        kappa.setScreenInfo(sceneWidth : self.scene!.size.width)
        kappa.setPhysic()
    }
    
    public func makeSpark(_ pos : CGPoint){
        let node = SparkEmitterNode.makeSpark(0.3)
        node.position = pos
        self.addChild(node)
    }

    public func setWorld(){
        physicsWorld.contactDelegate = self
        let underground = childNode(withName: "//underground") as? WorldNode
        underground?.setPhysic()
    }
    
    /**************************************************************************/
    /************************ tap              *****************************************/
    /**************************************************************************/
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
            let to_scale = CGFloat(5 + CommonUtil.rnd(11))
            n.run(SKAction.sequence([
                SKAction.scale(to: to_scale, duration: 0.3),
                SKAction.wait(forDuration: 1.0),
                SKAction.fadeOut(withDuration: 0.6),
                SKAction.removeFromParent()
            ]))
        }
    }
    
    public func displayDamage(_ text : String, _ pos : CGPoint, _ color : UIColor = .white) {
        let label = SKLabelNode(fontNamed: "Cochin-Bold")
        label.text = text
        label.fontSize = 46
        label.fontColor = color
        label.horizontalAlignmentMode = .center
        label.position = pos

        let animation = SKAction.sequence([
            SKAction.moveBy(x: 0, y: 50.0, duration: 0.8),
            SKAction.wait(forDuration: 0.3),
            SKAction.fadeOut(withDuration: 0.6),
            SKAction.removeFromParent()
        ])
        label.run(animation)
        self.addChild(label)
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
