//
//  Enum.swift
//  wakeAndSnakey
//
//  Created by pro on 7/3/19.
//  Copyright © 2019 tonynomadscoderad. All rights reserved.
//

import Foundation

enum ArrowKeys {
  case leftKey
  case rightKey
  case upKey
  case downKey
}

enum CurrentDirection {
  case left
  case right
  case up
  case down
}

struct tileMapPosition {
  var x: Int
  var y: Int
  init(x: Int, y: Int) {
    self.x = x
    self.y = y
  }
}


