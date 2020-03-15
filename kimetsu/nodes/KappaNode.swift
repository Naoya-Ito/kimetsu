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

    }
    
    public func moveRight(){
        if isMoving {
            return
        }
        isMoving = true
        pos += 1
        xScale = 1

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
}