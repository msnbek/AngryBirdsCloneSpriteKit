//
//  GameScene.swift
//  AngryBirdClone
//
//  Created by Mahmut Şenbek on 16.11.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // var bird2 = SKSpriteNode()
    var score = 0
    var scoreLabel = SKLabelNode()
    
    
    var bird = SKSpriteNode()
    
    var box1 = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    
    var gameStarted = false
    
    var originalPosition : CGPoint?
    var box1OriginalPosition : CGPoint?
    var box2OriginalPosition : CGPoint?
    var box3OriginalPosition : CGPoint?
    var box4OriginalPosition : CGPoint?
    var box5OriginalPosition : CGPoint?
    
    enum ColliderType : UInt32 {
        case Bird = 1
        case Box = 2
        // case Tree = 8
        
    }
    
    
    override func didMove(to view: SKView) {
        /*
         let texture = SKTexture(imageNamed: "bird")
         bird2 = SKSpriteNode(texture: texture)
         bird2.position = CGPoint(x: 0, y: 0)
         bird2.size = CGSize(width: self.frame.width / 16 , height: self.frame.height / 10)
         bird2.zPosition = 1
         self.addChild(bird2)
         */
        //PhysicsBody
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame )
        self.scene?.scaleMode = .aspectFit
        self.physicsWorld.contactDelegate = self
        //Bird
        //Game Scenedeki kuşu koda tanımladık ve fiziksel özellikler ekledik.
        bird = childNode(withName: "bird") as! SKSpriteNode     // gameScene'daki kuşu tanımladık.
        let birdTexture = SKTexture(imageNamed: "bird")
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 14)  // Fizik bodysi.
        bird.physicsBody?.affectedByGravity = false // Yerçekiminden etkilenme.
        bird.physicsBody?.isDynamic = true  // fiziksel similasyonlardan ekilenme.
        bird.physicsBody?.mass =  0.15 // kütlesi
        originalPosition = bird.position
        
        
        //Nesnelerin Çarpışması
        
        bird.physicsBody?.contactTestBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.collisionBitMask = ColliderType.Box.rawValue
        
        //Boxes
        let boxTexture = SKTexture(imageNamed: "brick")
        let size = CGSize(width: boxTexture.size().width / 4.75, height: boxTexture.size().height / 4.75)
        var mass = physicsBody?.mass
        mass = 0.4
     
        
        // Box 1
        box1 = childNode(withName: "box1") as! SKSpriteNode
        box1.physicsBody = SKPhysicsBody(rectangleOf: size)
        box1.physicsBody?.isDynamic = true
        box1.physicsBody?.affectedByGravity = true
        box1.physicsBody?.allowsRotation = true
        box1.physicsBody?.mass = mass!
        box1OriginalPosition = box1.position
        
        box1.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        //Box2
        box2 = childNode(withName: "box2") as! SKSpriteNode
        box2.physicsBody = SKPhysicsBody(rectangleOf: size)
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.affectedByGravity = true
        box2.physicsBody?.allowsRotation = true
        box2.physicsBody?.mass = mass!
        box2OriginalPosition = box2.position
        
        box2.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        //Box3
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box3.physicsBody = SKPhysicsBody(rectangleOf: size)
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.affectedByGravity = true
        box3.physicsBody?.allowsRotation = true
        box3.physicsBody?.mass = mass!
        box3OriginalPosition = box3.position
        
        box3.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        //Box 4
        box4 = childNode(withName: "box4") as! SKSpriteNode
        box4.physicsBody = SKPhysicsBody(rectangleOf: size)
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody?.allowsRotation = true
        box4.physicsBody?.mass = mass!
        box4OriginalPosition = box4.position
        
        box4.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        //Box5
        box5 = childNode(withName: "box5") as! SKSpriteNode
        box5.physicsBody = SKPhysicsBody(rectangleOf: size)
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.affectedByGravity = true
        box5.physicsBody?.allowsRotation = true
        box5.physicsBody?.mass = mass!
        box5OriginalPosition = box5.position
        
        box5.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        //Label
        
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 4)
        scoreLabel.zPosition = 2
        self.addChild(scoreLabel)
        
        
        
    }
    // kutu ile kuş birbirine değerse
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue || contact.bodyB.collisionBitMask == ColliderType.Bird.rawValue {
            score += 1
            scoreLabel.text = String(score)
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
       
    }
    
    func touchMoved(toPoint pos : CGPoint) {
      
    }
    
    func touchUp(atPoint pos : CGPoint) {
      
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      /*
        bird.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 100))
        bird.physicsBody?.affectedByGravity = true
        */
        // Dokunulan Konumu aldık.
        if gameStarted == false {
            
            if let touch = touches.first {
                let touchedLocation = touch.location(in: self)
                let touchedNodes = nodes(at: touchedLocation)
                if touchedNodes.isEmpty == false {
                    
                    for node in touchedNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchedLocation
                            }
                        }
                    }
                }
            }
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false {
            
            if let touch = touches.first {
                let touchedLocation = touch.location(in: self)
                let touchedNodes = nodes(at: touchedLocation)
                if touchedNodes.isEmpty == false {
                    
                    for node in touchedNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchedLocation
                            }
                        }
                    }
                }
            }
            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false {
            
            if let touch = touches.first {
                let touchedLocation = touch.location(in: self)
                let touchedNodes = nodes(at: touchedLocation)
                if touchedNodes.isEmpty == false {
                    
                    for node in touchedNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                            let dx = -(touchedLocation.x - originalPosition!.x)
                                let dy = -(touchedLocation.y - originalPosition!.y)
                                let impulse = CGVector(dx: dx, dy: dy)
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.affectedByGravity = true
                                
                                gameStarted = true
                            
                                
                            }
                        }
                    }
                }
            }
            
        }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    //Reset için kullanılır, devamlı kontrol eder.
    override func update(_ currentTime: TimeInterval) {
        
        if let birdPhysicsBody = bird.physicsBody {
            if birdPhysicsBody.velocity.dx <= 0.1 && birdPhysicsBody.velocity.dy <= 0.1 && birdPhysicsBody.angularVelocity <= 0.1 && gameStarted == true {
                
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.physicsBody?.angularVelocity = 0
                bird.zPosition = 3
                bird.position = originalPosition!
                box1.position = box1OriginalPosition!
                box2.position = box2OriginalPosition!
                box3.position = box3OriginalPosition!
                box4.position = box4OriginalPosition!
                box5.position = box5OriginalPosition!
                gameStarted = false
                scoreLabel.text = "0"
                
            }
        }
    }
}
