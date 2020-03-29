// チュートリアルボス 竜巻旋風脚
import Foundation
import SpriteKit
import GameplayKit
class TutorialBossScene: BaseScene {
    
    private var enemy : EnemyNode = EnemyNode()
    private var door : DoorNode = DoorNode()
    private let ENEMY_POSITION = 4
    private let MAX_POSITION = 6

    override func sceneDidLoad() {
        commonSceneDidLoad()
        setKappa()
        setWorld()
        addFire()
        addEnemy()
    }
    
    private func addFire(){
        let fire_light = self.childNode(withName: "//fire_light") as! SKLightNode
        let fire = FireEmitterNode.makeFire()
        fire.position = fire_light.position
        self.addChild(fire)
    }
    
    private func addEnemy(){
        enemy = EnemyNode(imageNamed: "cat")
        enemy.setPhysic()
        let pos = CGFloat(ENEMY_POSITION)
        enemy.position.x = kappa.position.x + (self.size.width)/7.0*pos + Const.ENEMY_SPACE
        enemy.position.y = kappa.position.y
        enemy.buffaloMove()
        self.addChild(enemy)
    }
        
    private func shot(){
        let hado = HadoNode.makeHado()
        hado.position = kappa.positionRight()
        addChild(hado)
        hado.shot()
    }
    
    private func damagedEnemy(){
        let damage = 1 + CommonUtil.rnd(3)
        enemy.hp -= damage
        displayDamage("\(damage)", enemy.positionTop())
        makeSpark(enemy.rndPos())
        if enemy.hp <= 0 {
            beatEnemy()
        }
    }
    
    private func beatEnemy(){
        enemy.beatAway()
        door.fadeAway()
    }
    
    /**************************************************************************/
    /************************ 遷移             *****************************************/
    /**************************************************************************/
    private func goNextTutorial(){
        if onceFlag {
            return
        }
        onceFlag = true

        let nextScene = StoryScene(fileNamed: "StoryScene")!
        nextScene.size = self.scene!.size
        nextScene.scaleMode = SKSceneScaleMode.aspectFit
        nextScene.key = "tutorial"
        view!.presentScene(nextScene, transition: .doorway(withDuration: 1.3))
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
                    damagedEnemy()
                case "tornado":
                    damagedEnemy()
                case "beat":
                    break
                default:
                    kappa.beDamaged()
                }
            }
        } else if firstBody.categoryBitMask & Const.enemyCategory != 0 {
            if secondBody.categoryBitMask & Const.hadoCategory != 0 {
                damagedEnemy()
            }
        }
    }
    
    /**************************************************************************/
    /************************ tap             ******************************************/
    /**************************************************************************/
    override func touchDown(atPoint pos : CGPoint) {
        if kappa.kappaMode == "beat" {
            return
        }
        let tapNodes = self.nodes(at: pos)
        for tapNode in tapNodes {
            if let name = tapNode.name {
                switch name {
                case "hado":
                    kappa.hado()
                    shot()
                    return
                case "upper":
                    kappa.upper()
                    return
                case "tornado":
                    kappa.tornado()
                    return
                default:
                    break
                }
            }
        }

        if pos.x < 0 {
            if kappa.pos <= 0 {
                kappa.moveLeftBack()
            } else {
                kappa.moveLeft()
            }
        } else {
            if kappa.pos == MAX_POSITION - 1 {
                kappa.normalAttack()
                return
            }
            
            if kappa.pos >= Const.MAX_KAPPA_POSITION {
                goNextTutorial()
            } else {
                kappa.moveRight()
            }
        }
        makeHamon(pos)
    }
}
