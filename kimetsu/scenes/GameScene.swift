import SpriteKit
import GameplayKit

class GameScene: BaseScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var kappa : SKSpriteNode = SKSpriteNode()
    
    override func sceneDidLoad() {
        commonSceneDidLoad()
    }

    override func didMove(to view: SKView) {
        kappa = self.childNode(withName: "//kappa") as! SKSpriteNode
    }
    
    private func moveRight(){
        kappa.position.x += 20
        
    }
    
    private func moveLeft(){
        kappa.position.x -= 20
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if pos.x < 0 {
            moveLeft()
        } else {
            moveRight()
        }

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
