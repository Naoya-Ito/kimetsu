import Foundation
import SpriteKit
import GameplayKit
class Tutorial3Scene: BaseScene {
    
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
        let enemy = EnemyNode(imageNamed: "ghost")
        enemy.setPhysic()
        enemy.position.x = kappa.position.x + (self.size.width)/7.0*3 + Const.ENEMY_SPACE
        enemy.position.y = kappa.position.y
        self.addChild(enemy)
    }
    
    private func goNextTutorial(){
        
    }
    
    override func touchDown(atPoint pos : CGPoint) {
        let tapNodes = self.nodes(at: pos)
        for tapNode in tapNodes {
            if let name = tapNode.name {
                switch name {
                case "hado":
                    print("hado")
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
            if kappa.pos == ENEMY_POSITION - 1 {
                if enemy.hp > 0 {
                    kappa.normalAttack()
                    displayDamage("Miss", enemy.positionTop())
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
