import SpriteKit
import GameplayKit

class GameScene: BaseScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var kappa : KappaNode = KappaNode()
    
    override func sceneDidLoad() {
        commonSceneDidLoad()
        kappa = self.childNode(withName: "//kappa") as! KappaNode
    }

    override func didMove(to view: SKView) {
    }
    
    override func touchDown(atPoint pos : CGPoint) {
        if pos.x < 0 {
            kappa.moveLeft()
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
