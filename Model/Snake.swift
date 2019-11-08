//
//  Snake.swift
//  wakeAndSnakey
//
//  Created by pro on 7/3/19.
//  Copyright © 2019 tonynomadscoderad. All rights reserved.
//
import SpriteKit

class Snake {
  var headPostion: tileMapPosition
  var body = [tileMapPosition]()
  var maxLength = 4
  var currentDirection = CurrentDirection.up
  let TileSet = SKTileSet(named: "TileMap")
  var tMap:SKTileMapNode
  var nextHeadPosition = tileMapPosition(x: 0, y: 0)
  var gameScene: GameScene
  
  init(mapMaxX: Int, mapMaxY: Int, scene: GameScene) {
    let headstartX = mapMaxX/2
    var headstartY = mapMaxY/2
    self.headPostion = tileMapPosition(x: headstartX, y: headstartY)
    self.body.append(headPostion)
    self.gameScene = scene
    self.tMap = scene.tMap
    
    
    
    //create an array of body part coordinates
    for _ in 1..<maxLength{
      headstartY -= 1
      let bodyPartPosition = tileMapPosition(x: headstartX, y: headstartY)
      body.append(bodyPartPosition)
    }
    
    
    //draws the body of the snake
    for i in 0..<body.count{
      let xPos = body[i].x
      let yPos = body[i].y
      tMap.setTileGroup(TileSet?.tileGroups[1], forColumn: xPos, row: yPos)
    }
  }
  
  func move(){
    nextHeadPosition = findNextHeadPosition()
    checkForEdgeOfMap()
    checkForApple()
    checkForSelf()
    drawMovement()
    cleanTail()
  }
  
  func findNextHeadPosition() -> tileMapPosition{
    switch currentDirection {
    case .up:
      return tileMapPosition(x: headPostion.x , y: headPostion.y + 1)
    case .down:
      return tileMapPosition(x: headPostion.x , y: headPostion.y - 1)
    case .left:
      return tileMapPosition(x: headPostion.x - 1, y: headPostion.y)
    case .right:
      return tileMapPosition(x: headPostion.x + 1 , y: headPostion.y)
    }
  }
  
  func checkForEdgeOfMap(){
    if tMap.tileDefinition(atColumn: nextHeadPosition.x, row: nextHeadPosition.y) == nil{
      gameScene.Die()
    }
  }
  
  func checkForApple(){
    if tMap.tileDefinition(atColumn: nextHeadPosition.x, row: nextHeadPosition.y)?.name == "Apple"{
      maxLength += 1
      gameScene.snakeAteAnApple()
    }
  }
  
  func checkForSelf(){
    if tMap.tileDefinition(atColumn: nextHeadPosition.x, row: nextHeadPosition.y)?.name == "SnakePiece"{
      gameScene.Die()
    }
  }
  
  func drawMovement(){
    headPostion = nextHeadPosition
    body.insert(headPostion, at: 0)
    tMap.setTileGroup(TileSet?.tileGroups[1], forColumn: headPostion.x, row: headPostion.y)
  }
  
  func cleanTail() {
    if body.count > maxLength{
      let lastSpot = body[maxLength]
      tMap.setTileGroup(TileSet?.tileGroups[2], forColumn: lastSpot.x, row: lastSpot.y)
    }
  }
  
}


