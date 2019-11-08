//
//  GameScene.swift
//  wakeAndSnakey
//
//  Created by pro on 7/3/19.
//  Copyright © 2019 tonynomadscoderad. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
  var hasApple = false
  var tMap: SKTileMapNode!
  var tMapMaxX: Int!
  var tMapMaxY: Int!
  var snake: Snake!
  var gamerTimer: Timer!
  let TileSet = SKTileSet(named: "TileMap")
  var timeStepLength = 0.1
  var scoreLabel: SKLabelNode!
  var score = 0{
    didSet{
      scoreLabel.text = "Score: \(score)"
    }
  }
  var isGameOver = false
  
  override func didMove(to view: SKView) {
    scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
    scoreLabel.text = "Score: 0"
    scoreLabel.horizontalAlignmentMode = .left
    scoreLabel.position = CGPoint(x:20, y: 728)
    scoreLabel.fontColor = .red
    addChild(scoreLabel)
    
    tMap = childNode(withName: "TileMap") as? SKTileMapNode
    tMapMaxX = tMap?.numberOfColumns
    tMapMaxY = tMap?.numberOfRows
    
    startGame()

  }
  
  
  func startGame(){
  snake = Snake(mapMaxX: tMapMaxX, mapMaxY: tMapMaxX, scene: self)
  gamerTimer = Timer.scheduledTimer(timeInterval: timeStepLength, target: self, selector: #selector(gameCycle), userInfo: nil, repeats: true)
  }

  @objc func gameCycle(){
    if !hasApple{
      makeApple()
    }
    snake.move()
  }
  
  func makeApple(){
    let apple = Apple(maxX: tMapMaxX, maxY: tMapMaxY)
    guard let appleX = apple.position?.x else{ return }
    guard let applyY = apple.position?.y else { return }
    if tMap.tileDefinition(atColumn: appleX, row: applyY)?.name == "Grid"{
    tMap.setTileGroup(TileSet?.tileGroups[0], forColumn: appleX, row: applyY)
    hasApple = true
    } else{
      makeApple()
      return
    }
  }
  
  override func keyDown(with event: NSEvent) {
    switch event.keyCode{
    case 123:
      print("Left Key")
      snake.currentDirection = .left
    case 124:
      print("Right Key")
      snake.currentDirection = .right
    case 125:
      print("Down key")
      snake.currentDirection = .down
    case 126:
      print("Up key")
      snake.currentDirection = .up
      
    default:
      print(" you press key#: \(event.keyCode)")
      if isGameOver {
        restartGame()
      }
    }
  }

  
  func snakeAteAnApple(){
    hasApple = false
    score += 1
  }
  
  func Die(){
    gamerTimer.invalidate()
    isGameOver = true
    let gameOverLabel = SKLabelNode(fontNamed: "chalkduster")
    gameOverLabel.text = "GAME OVER!\npress any key\n  to restart"
    gameOverLabel.name = "gameOverLabel"
    gameOverLabel.numberOfLines = 0
    gameOverLabel.fontSize = 60
    gameOverLabel.fontColor = .red
    gameOverLabel.position = CGPoint(x: 600, y: 368)
    addChild(gameOverLabel)
  }
  
  
  
  func restartGame(){
    tMap.fill(with: TileSet?.tileGroups[2])
    childNode(withName: "gameOverLabel")?.removeFromParent()
    score = 0
    hasApple = false
    startGame()
  }
  
}
