//
//  FigureModel.swift
//  TicTacToe
//
//  Created by Камиль Сулейманов on 25.08.2021.
//

import SwiftUI

struct Figure: Identifiable, Hashable {
    let id: Int
    var figure: String
    var color = Color.blue
    var isHiden = true
}

let winingPositions = [
    [4, 5, 6],
    [2, 5, 8],
    [1, 5, 9],
    [3, 5, 7],
    [1, 2, 3],
    [7, 8, 9],
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9],
]

