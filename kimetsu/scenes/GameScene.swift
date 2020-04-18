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
        for i in 2 ... 5 {
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
    /************************ tap             ******************************************/
    /**************************************************************************/
    override func touchDown(atPoint pos : CGPoint) {
        if pos.x < 0 {
            moveLeft()
        } else {
            moveRight()
        }
        makeHamon(pos)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        let dt = currentTime - self.lastUpdateTime
        
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        self.lastUpdateTime = currentTime
    }
}
