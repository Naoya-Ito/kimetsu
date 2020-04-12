// チュートリアル2 攻撃
import Foundation
import SpriteKit
import GameplayKit
class Tutorial2Scene: BaseScene {
    
    private var enemy : EnemyNode = EnemyNode("slime")
    private let ENEMY_POSITION = 4

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
    
    private func damagedEnemy(){
        let damage = 1 + CommonUtil.rnd(3)
        enemy.hp -= damage
        displayDamage("\(damage)", enemy.positionTop())
        makeSpark(enemy.rndPos())
        if enemy.hp <= 0 {
            enemy.beatAway()
        }
    }
    
    private func addEnemy(){
        enemy = EnemyNode("slime1")
        enemy.setPhysic()
        enemy.setAnimation()    
        enemy.hp = 20
        enemy.position = getPosition(ENEMY_POSITION)
        self.addChild(enemy)
    }
    
    /**************************************************************************/
    /************************ 遷移             *****************************************/
    /**************************************************************************/
    private func goNextTutorial(){
        if onceFlag {
            return
        }
        onceFlag = true

        UserDefaults.standard.set(true, forKey: "is_clear_tutorial2")
        
        let nextScene = Tutorial3Scene(fileNamed: "Tutorial3Scene")!
        nextScene.size = self.scene!.size
        nextScene.scaleMode = SKSceneScaleMode.aspectFit
        view!.presentScene(nextScene, transition: .doorway(withDuration: 1.3))
    }
    
    /**************************************************************************/
    /************************ tap             ******************************************/
    /**************************************************************************/
    override func touchDown(atPoint pos : CGPoint) {
        if pos.x < 0 {
            if kappa.pos <= 0 {
                kappa.moveLeftBack()
            } else {
                kappa.moveLeft()
            }
        } else {
            if kappa.pos == ENEMY_POSITION - 1 {
                if enemy.hp > 0 {
                    kappa.normalAttack()
                    damagedEnemy()
                    return
                }
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
