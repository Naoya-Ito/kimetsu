import Foundation
import SpriteKit

class KappaNode : SKSpriteNode {
    
    private var isMoving = false
    public var pos = 0
    
    private var moveSpeed : TimeInterval = 0.07
    private var moveSpace : CGFloat = 0.0
    private var jumpSpace : CGFloat = 25.0
    
    
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
        
        let images = ["kappa_punch", "kappa_upper", "kappa_kick", "kappa_body", "kappa_punch_r", "kappa_flying"]
        let image = images[CommonUtil.rnd(images.count)]
        texture = SKTexture(imageNamed: image)
        run(normalAttackAnimation, completion: {
            self.isMoving = false
        })
    }
    
    // 波動の構え
    public func hado(){
        xScale = 1
        texture = SKTexture(imageNamed: "kappa_punch")
    }
    
    public func positionRight() -> CGPoint {
        return CGPoint(x: position.x + 60, y: position.y)
        
    }
}
