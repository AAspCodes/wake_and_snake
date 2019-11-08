//
//  Apple.swift
//  wakeAndSnakey
//
//  Created by pro on 7/3/19.
//  Copyright © 2019 tonynomadscoderad. All rights reserved.
//

import Foundation

class Apple {
  let maxX: Int!
  let maxY: Int!
  var position: tileMapPosition?
  
  init (maxX: Int, maxY: Int){
    self.maxX = maxX
    self.maxY = maxY
    self.position = findRandomposition(maxX,maxY)
  }
  
  private func findRandomposition(_ maxX: Int, _ maxY: Int) -> tileMapPosition{
    let randomX = Int.random(in: 0..<maxX)
    let randomY = Int.random(in: 0..<maxY)
    return tileMapPosition(x: randomX, y: randomY)
  }
}
