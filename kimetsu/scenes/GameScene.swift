import SpriteKit
import GameplayKit

class GameScene: BaseScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    override func sceneDidLoad() {
        commonSceneDidLoad()
        setKappa()
    }

    override func didMove(to view: SKView) {
    }
    
    override func touchDown(atPoint pos : CGPoint) {
        if pos.x < 0 {
            if kappa.pos <= 0 {
                kappa.moveLeftBack()
            } else {
                kappa.moveLeft()
            }
        } else {
            kappa.moveRight()
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
