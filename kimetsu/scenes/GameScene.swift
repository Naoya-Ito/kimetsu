import SpriteKit
import GameplayKit

class GameScene: BaseScene {
    
    public var floor = 0
    public var stage_key = ""
    public var stage : Stage!
    public var enemy_pos : [Bool] = [false,false,false,false]
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    override func sceneDidLoad() {
        commonSceneDidLoad()
        setKappa()
        setWorld()
        initCircle()
    }
    
    private func initCircle(){
        self.addChild(circle)
        
        var points = [CGPoint(x: 0, y: 0), CGPoint(x: 120,y: 0)]
        arrow = SKShapeNode(points: &points, count: points.count)
        arrow.zPosition = 99
        arrow.strokeColor = .blue
        arrow.alpha = 0.0
        arrow.lineWidth = 5
        self.addChild(arrow)
    }

    private var once_load = false
    override func didMove(to view: SKView) {
        if once_load {
            return
        }
        if floor == 0 {
            loadStageData()
        }
        addEnemy()
    }
    
    private func loadStageData(){
        stage = Stage(stage_key)
    }
    
    private func addEnemy(){
        return
        for i in 2 ... 3 {
            let enemy_name = CommonUtil.getRandomByArray(stage.enemies + [""])
            if enemy_name == "" {
                continue
            }
            let enemy = EnemyNode(enemy_name)
            enemy.setPhysic()
            enemy.position = getPosition(i)
            enemy.pos = i
            enemy_pos[2-i] = true
            self.addChild(enemy)
        }
    }
    
    /***********************************************************************************/
    /********************************** 衝突判定 ****************************************/
    /***********************************************************************************/
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody, secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if firstBody.node == nil || secondBody.node == nil {
            return
        }

        if firstBody.categoryBitMask & Const.kappaCategory != 0 {
            if secondBody.categoryBitMask & Const.enemyCategory != 0 {
                switch kappa.kappaMode {
                case "upper":
//                    damagedEnemy()
                    break
                case "tornado":
//                    damagedEnemy()
                    break
                case "beat":
                    break
                default:
                    kappa.beDamaged()
                }
            }
        } else if firstBody.categoryBitMask & Const.enemyCategory != 0 {
            if secondBody.categoryBitMask & Const.hadoCategory != 0 {
//                damagedEnemy()
            }
        }
    }
    
    /**************************************************************************/
    /************************ 移動            ******************************************/
    /**************************************************************************/
    private func moveLeft(){
        if kappa.pos <= 0 {
            kappa.moveLeftBack()
        } else {
            kappa.moveLeft()
        }
    }
    
    // MAX_KAPPA : 6
    private func moveRight(){
        if kappa.pos >= Const.MAX_KAPPA_POSITION - 1 {
            //  次のマップへ
        } else if kappa.pos >= 1 && enemy_pos[kappa.pos+1] {
            kappa.normalAttack()
        } else {
            kappa.moveRight()
        }
    }

    /**************************************************************************/
    /************************ 上スワイプ   ****************************************/
    /**************************************************************************/

    private func swipeUp(){
        kappa.jump()
    }

    
    /**************************************************************************/
    /************************ 円マーク      ****************************************/
    /**************************************************************************/
    private var circle = CircleNode(fillColor: .clear)
    private var arrow : SKShapeNode = SKShapeNode()
    
    // 直線を描画
    public func createLine(from: CGPoint, target: CGPoint, color: UIColor = .black){
        let LENGTH : CGFloat = 2000.0
        let radian = atan2(target.y - from.y, target.x - from.x)
        let x = LENGTH*cos(radian)
        let y = LENGTH*sin(radian)
        var points = [CGPoint(x: 0, y: 0), CGPoint(x:x,y:y)]
        let action = SKAction.sequence([
            SKAction.fadeOut(withDuration: 1.0),
            SKAction.removeFromParent()
            ])
        let shape = SKShapeNode(points: &points, count: points.count)
        shape.strokeColor = color
        shape.run(action)
        shape.position = from
        self.addChild(shape)
    }
    
    public func hideCircleAndArrow(){
        circle.fadeOut()
        let fadeAction = SKAction.fadeOut(withDuration: 0.2)
        arrow.run(fadeAction)
    }
    
    /**************************************************************************/
    /************************ tap             ******************************************/
    /**************************************************************************/
    private var beganPos = CGPoint(x: 0, y: 0)
    override func touchDown(atPoint pos : CGPoint) {
        circle.setCircle(pos)
        arrow.position = pos
        beganPos = pos
    }
    
    override func touchMoved(toPoint pos : CGPoint) {
        let distance = hypot(pos.x - beganPos.x, pos.y - beganPos.y)
        var to_scale = distance/100.0
        if to_scale > 1.0 {
            to_scale = 1.0
        }
        circle.setScale(to_scale)
        arrow.setScale(to_scale)
        arrow.alpha = 1.0
        
        let radian = atan2(beganPos.y - pos.y, beganPos.x - pos.x)
        arrow.run(SKAction.rotate(toAngle: radian, duration: 0))
    }

    override func touchUp(atPoint pos : CGPoint) {
        let vector = CGVector(dx: 2*(beganPos.x - pos.x), dy: 2*(beganPos.y - pos.y))
        kappa.kappaAction(vector)
        
        hideCircleAndArrow()
    }
    
    
    /**************************************************************************/
    /************************ update             ******************************************/
    /**************************************************************************/

    override func update(_ currentTime: TimeInterval) {
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        let dt = currentTime - self.lastUpdateTime
        
        if kappa.physicsBody?.velocity == CGVector(dx:0, dy:0) {
            kappa.kappaMode = "normal"
            kappa.texture = SKTexture(imageNamed: "kappa")
        }
        
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        self.lastUpdateTime = currentTime
    }
}
