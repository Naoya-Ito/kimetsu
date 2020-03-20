import Foundation
import SpriteKit
import GameplayKit
class Tutorial2Scene: BaseScene {
    
    private var enemy : EnemyNode = EnemyNode()
    private let ENEMY_POSITION = 3

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
        print("added enemy")
        let enemy = EnemyNode(imageNamed: "tanuki")
        enemy.setPhysic()
        enemy.position.x = kappa.position.x + (self.size.width)/7.0*3 + Const.ENEMY_SPACE
        enemy.position.y = kappa.position.y
        self.addChild(enemy)
    }
    
    private func goNextTutorial(){
        if onceFlag {
            return
        }
        onceFlag = true

        let nextScene = Tutorial3Scene(fileNamed: "Tutorial3Scene")!
        nextScene.size = self.scene!.size
        nextScene.scaleMode = SKSceneScaleMode.aspectFit
        view!.presentScene(nextScene, transition: .doorway(withDuration: 1.3))
    }
    
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
                    enemy.hp -= 1 + CommonUtil.rnd(3)
                    displayDamage("1", enemy.positionTop())
                    makeSpark(enemy.rndPos())
                    if enemy.hp <= 0 {
                        enemy.beatAway()
                        
                        let beatAction = SKAction.moveBy(x: 1000.0, y: CGFloat(CommonUtil.rnd(300)), duration: 0.3)
                        
                        enemy.run(beatAction, completion: {
                            self.removeFromParent()
                        })

                        
                    }
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
