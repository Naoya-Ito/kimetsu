import Foundation
import SpriteKit

class EnemyNode : SKSpriteNode {
    
    public var hp = 10
    public var pos = 0
    
    init(_ key : String, _ lv : Int = 1) {
        let tmp_texture = SKTexture(imageNamed: key)
        super.init(texture: tmp_texture, color: .white, size: tmp_texture.size())

        switch key {
        case "slime":
            setAnimation(key)
            break
        default:
            texture = SKTexture(imageNamed: key)
        }
        zPosition = 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setAnimation(_ key : String){
        var textures : [SKTexture] = []
        let atlas = SKTextureAtlas(named: key)
         for i in 1...2 {
             textures.append(atlas.textureNamed("\(key)\(i)"))
         }
        let animation = SKAction.animate(with: textures, timePerFrame: 0.5)
        run(SKAction.repeatForever(animation))
    }
    
    public func setLight(){
        let light = SKLightNode()
        light.falloff = 1.5

        light.categoryBitMask = 1
        light.position = CGPoint(x: 0, y: 0)
        self.addChild(light)
    }
    
    
    // 物理属性を適用
    public func setPhysic(){
        let centerPoint = CGPoint(x: 0, y: 64)
        let p_size = self.texture!.size()
        let physic = SKPhysicsBody(rectangleOf: p_size, center: centerPoint)
        physic.affectedByGravity = false
        physic.allowsRotation = true
        physic.isDynamic = true
        physic.categoryBitMask = Const.enemyCategory
        physic.contactTestBitMask = Const.hadoCategory
        physic.collisionBitMask = 0
        physic.linearDamping = 0
        physic.friction = 0
        physicsBody = physic
    }
    
    
    public func rndPos() -> CGPoint {
        let pos_x = position.x + 30
        let pos_y = position.y + 10
        
        return CommonUtil.rndPos(CGPoint(x: pos_x, y: pos_y), width: 100)
    }
    
    // 吹っ飛んで消える
    public func beatAway(){
        physicsBody?.allowsRotation = true
        physicsBody?.applyTorque(-75.0)
        
        //        let vect = CGVector(dx: 1000, dy: CommonUtil.rnd(300))
//        let beatAction = SKAction.move(by: vect, duration: 0.6)
        
        let beatAction = SKAction.sequence([
            SKAction.moveBy(x: 800.0, y: CGFloat(CommonUtil.rnd(300)), duration: 0.5),
            SKAction.removeFromParent()
        ])
        run(beatAction)
    }
    
    public func positionTop() -> CGPoint {
        let top_pos = CGPoint(x: position.x + 10, y: position.y + 120)
        
        return top_pos
    }
    
    public func buffaloMove(){
        let action = SKAction.sequence([
            SKAction.moveBy(x: 20.0, y: 30.0, duration: 0.25),
            SKAction.moveBy(x: 20.0, y: -30.0, duration: 0.25),
            SKAction.moveTo(x: -250.0, duration: 0.75)
        ])
        let backAction = SKAction.sequence([
            SKAction.moveBy(x: -20.0, y: 30.0, duration: 0.25),
            SKAction.moveBy(x: -20.0, y: -30.0, duration: 0.25),
            SKAction.moveTo(x: 250.0, duration: 0.75)
        ])

        run(action, completion: {
            self.xScale = -1
            self.run(backAction, completion: self.buffaloMove)
        })
    }
}
