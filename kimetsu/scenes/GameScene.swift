import SpriteKit
import GameplayKit

class GameScene: BaseScene {
    
    public var floor = 0
    public var stage_key = ""
    public var stage : Stage!
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var once_load = false
    override func sceneDidLoad() {
        if once_load {
            return
        }
        commonSceneDidLoad()
        setKappa()
        print("stage_key=\(stage_key)")
        if floor == 0 {
            loadStageData()
        }
        addEnemy()
    }

    override func didMove(to view: SKView) {
        print("did moved")
    }
    
    private func loadStageData(){
        stage = Stage(stage_key)
    }
    
    private func addEnemy(){
        for i in 1 ... 4 {
            let enemy_name = CommonUtil.getRandomByArray(stage.enemies)
            let enemy = EnemyNode(enemy_name)
            enemy.setPhysic()
            enemy.position = getPosition(i+2)
            self.addChild(enemy)
        }
    }

    private func moveLeft(){
        if kappa.pos <= 0 {
            kappa.moveLeftBack()
        } else {
            kappa.moveLeft()
        }
    }
    
    private func moveRight(){
        if kappa.pos >= Const.MAX_KAPPA_POSITION {
            //  次のマップへ
        } else {
            kappa.moveRight()
        }
    }
    
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
