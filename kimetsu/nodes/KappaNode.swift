import Foundation
import SpriteKit

class KappaNode : SKSpriteNode {
    
    private var isMoving = false
    public var pos = 0
    
    public var jump_max_count = 2
    public var jump_count = 2
    
    public var kappaMode = "normal"
    
    private var moveSpeed : TimeInterval = 0.07
    private var moveSpace : CGFloat = 0.0
    private var jumpSpace : CGFloat = 25.0
    
    // 物理属性を適用
    public func setPhysic(){

        let p_size = self.texture!.size()
        let physic = SKPhysicsBody(rectangleOf: p_size)
//        let centerPoint = CGPoint(x: 0, y: 64)
//        let physic = SKPhysicsBody(rectangleOf: p_size, center: centerPoint)
        physic.affectedByGravity = true
        physic.allowsRotation = false
        physic.isDynamic = true
        physic.categoryBitMask = Const.kappaCategory
        physic.contactTestBitMask = Const.enemyCategory
        physic.collisionBitMask = Const.worldCategory
        physic.linearDamping = 0
        physic.friction = 0.8
        physicsBody = physic
    }

    // 画面情報やスキルで初期値をセット
    private var moveRightAnimation : SKAction!
    private var moveLeftAnimation : SKAction!
    private var moveLeftBackAnimation : SKAction!
    private var normalAttackAnimation : SKAction!
    public func setScreenInfo(sceneWidth : CGFloat){
        moveSpace = sceneWidth/7.0/4.0
        
        moveRightAnimation = SKAction.sequence([
            SKAction.moveBy(x: moveSpace, y:  jumpSpace, duration: moveSpeed),
            SKAction.moveBy(x: moveSpace, y: -jumpSpace, duration: moveSpeed),
            SKAction.moveBy(x: moveSpace, y:  jumpSpace, duration: moveSpeed),
            SKAction.moveBy(x: moveSpace, y: -jumpSpace, duration: moveSpeed),
        ])
        moveLeftAnimation = SKAction.sequence([
            SKAction.moveBy(x: -moveSpace, y:  jumpSpace, duration: moveSpeed),
            SKAction.moveBy(x: -moveSpace, y: -jumpSpace, duration: moveSpeed),
            SKAction.moveBy(x: -moveSpace, y:  jumpSpace, duration: moveSpeed),
            SKAction.moveBy(x: -moveSpace, y: -jumpSpace, duration: moveSpeed),
        ])
        
        moveLeftBackAnimation = SKAction.sequence([
            SKAction.moveBy(x: -moveSpace, y:  jumpSpace, duration: moveSpeed),
            SKAction.moveBy(x: -moveSpace, y: -jumpSpace, duration: moveSpeed),
            SKAction.moveBy(x:  moveSpace, y:  jumpSpace, duration: moveSpeed),
            SKAction.moveBy(x:  moveSpace, y: -jumpSpace, duration: moveSpeed),
        ])

        normalAttackAnimation = SKAction.sequence([
            SKAction.moveBy(x: moveSpace,  y: 0.0, duration: moveSpeed),
            SKAction.moveBy(x: -moveSpace, y: 0.0, duration: moveSpeed),
        ])
    }
    
    public func moveRight(){
        if isMoving {
            return
        }
        isMoving = true
        pos += 1
        xScale = 1
        texture = SKTexture(imageNamed: "kappa")
        run(moveRightAnimation, completion: {
            self.isMoving = false
        })
    }
    
    public func moveLeft(){
        if isMoving {
            return
        }
        isMoving = true
        pos -= 1
        xScale = -1
        texture = SKTexture(imageNamed: "kappa")
        run(moveLeftAnimation, completion: {
            self.isMoving = false
        })
    }
    
    // 壁で跳ね返ってしまう
    public func moveLeftBack(){
        if isMoving {
            return
        }
        isMoving = true
        xScale = -1
        _ = CommonUtil.setTimeout(delay: 2*moveSpeed, block: {
            self.xScale = 1
        })
        run(moveLeftBackAnimation, completion: {
            self.isMoving = false
        })
    }
    
    public func normalAttack(){
        if isMoving {
            return
        }
        isMoving = true
        xScale = 1
        
        if kappaMode != "tornado" {
            let images = ["kappa_punch", "kappa_upper", "kappa_kick", "kappa_body", "kappa_punch_r", "kappa_flying", "kappa_walk"]
            let image = images[CommonUtil.rnd(images.count)]
            texture = SKTexture(imageNamed: image)
        }
        run(normalAttackAnimation, completion: {
            self.isMoving = false
        })
    }

    public func stopKappa(){
        physicsBody?.velocity = CGVector(dx: 0, dy: 0)
    }
    
    public func kappaAction(_ value : CGVector){
        xScale = (value.dx >= 0) ? 1.0 : -1.0

        // ジャンプ中かどうか
        
        if value.dy >= 0 {
            if value.dy > value.dx {
                stopKappa()
                upper(value)
            } else {
                stopKappa()
                kappaKick(value)
            }
        } else {
            
        }
        
        
        
    }
    
    
    
    public func jump(){
        texture = SKTexture(imageNamed: "kappa_upper")

        let jumpAction = SKAction.sequence([
            SKAction.moveBy(x: 0, y: 250, duration: 0.25),
            SKAction.moveBy(x: 0, y: -250, duration:0.25),
            SKAction.moveBy(x: 0, y: 0,  duration: 0.25),
            ])
        jumpAction.timingMode = .linear
        run(jumpAction)
    }
    
    // 波動の構え
    public func hado(){
        xScale = 1
        texture = SKTexture(imageNamed: "kappa_punch")
    }
    
    public func upper(_ value: CGVector){
        texture = SKTexture(imageNamed: "kappa_upper")
        kappaMode = "upper"

        let MIN_POWER : CGFloat = 200.0
        let MAX_POWER : CGFloat = 700.0
        
        let speed_y : CGFloat
        if value.dy > MAX_POWER {
            speed_y = MAX_POWER
        } else if value.dy > MIN_POWER {
            speed_y = value.dy
        } else if value.dy > 0 {
            speed_y = MIN_POWER
        } else if value.dy > -MIN_POWER {
            speed_y = -MIN_POWER
        } else if value.dy > -MAX_POWER {
            speed_y = value.dy
        } else {
            speed_y = -MAX_POWER
        }

        let vector = CGVector(dx: value.dx, dy: speed_y)
        physicsBody?.applyImpulse(vector)
    }
    
    public func kappaKick(_ value : CGVector){
        texture = SKTexture(imageNamed: "kappa_walk")
        
        kappaMode = "kick"
        let MIN_POWER : CGFloat = 200.0
        let MAX_POWER : CGFloat = 700.0

        let speed_x : CGFloat
        if value.dx > MAX_POWER {
            speed_x = MAX_POWER
        } else if value.dx > MIN_POWER {
            speed_x = value.dx
        } else if value.dx > 0 {
            speed_x = MIN_POWER
        } else if value.dx > -MIN_POWER {
            speed_x = -MIN_POWER
        } else if value.dx > -MAX_POWER {
            speed_x = value.dx
        } else {
            speed_x = -MAX_POWER
        }

        let vector = CGVector(dx: speed_x, dy: value.dy)
        physicsBody?.applyImpulse(vector)
    }
    
    
    public func tornado(){
        if isRunnningAction() {
            return
        }
        
        kappaMode = "tornado"
        texture = SKTexture(imageNamed: "kappa_kick")
        spin_count = 0
        spin(50)
        let action = SKAction.sequence([
            SKAction.moveBy(x: 0,  y: 50, duration: 0.25),
            SKAction.wait(forDuration: 3.0),
            SKAction.moveBy(x: 0,  y: -50, duration:0.25),
        ])
        run(action, completion: {
            self.kappaMode = "normal"
        })
    }
    
    public var spin_count = 0
    public func spin(_ max_spin : Int){
        _ = CommonUtil.setTimeout(delay: 0.1, block: {
            self.spin_count += 1
            self.xScale *= -1
            if self.spin_count <= max_spin {
                self.spin(max_spin)
            }
        })
    }
    
    public func beDamaged(){
        kappaMode = "beat"
        texture = SKTexture(imageNamed: "kappa_beat")
        xScale = 1.0
        let action = SKAction.sequence([
            SKAction.moveBy(x: -30,  y: 60, duration: 0.7),
            SKAction.moveBy(x: 0,  y: -60, duration:0.3),
            SKAction.moveBy(x: 30,  y: 0, duration:0.3),
        ])
        run(action, completion: {
            self.texture = SKTexture(imageNamed: "kappa")
            self.kappaMode = "normal"
        })
    }
    
    
    public func positionRight() -> CGPoint {
        return CGPoint(x: position.x + 60, y: position.y)
    }
    
    
    public func isRunnningAction() -> Bool {
        return kappaMode == "tornado" || kappaMode == "upper"
    }
}
