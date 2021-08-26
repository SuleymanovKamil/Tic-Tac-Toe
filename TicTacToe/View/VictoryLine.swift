//
//  VictoryLine.swift
//  TicTacToe
//
//  Created by Камиль Сулейманов on 25.08.2021.
//

import SwiftUI

struct VictoryLine: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        Rectangle().frame(width: 5, height: UIScreen.main.bounds.width - 50, alignment: .center)
            .rotationEffect(.degrees(victoryLineAngle))
            .offset(x: Xoffset, y: Yoffset)
            .opacity(viewModel.endGame ? 1 : 0)
            .zIndex(1)
            .onChange(of: viewModel.currentStep, perform: { value in
                if value == 9 {
                    viewModel.bannerText = "DRAW!"
                    viewModel.resetGame(isResetButtonPressed: false)
                }
            })
            .onChange(of: viewModel.endGame, perform: { value in
                if value && viewModel.currentStep < 9 && viewModel.xLine.count > viewModel.oLine.count {
                    viewModel.xScore += 1
                    viewModel.bannerText = "X WIN!"
                    viewModel.resetGame(isResetButtonPressed: false)
                } else if value && viewModel.currentStep < 9 && viewModel.xLine.count == viewModel.oLine.count {
                    viewModel.oScore += 1
                    viewModel.bannerText = "O WIN!"
                    viewModel.resetGame(isResetButtonPressed: false)
                }
            })
    }
    
    private var Yoffset:CGFloat {
        var y:CGFloat  = 0
        
        if checkForWinPossition(for: viewModel.xLine, in: [1, 2, 3])
            ||  checkForWinPossition(for: viewModel.oLine, in: [1, 2, 3])
        { y = -100 }
        else if checkForWinPossition(for: viewModel.xLine, in: [7, 8, 9])
            ||  checkForWinPossition(for: viewModel.oLine, in: [7, 8, 9])
        { y = 100 }
        
        return y
    }
    
    private var Xoffset:CGFloat {
        
        var x:CGFloat  = 0
        
        if  checkForWinPossition(for: viewModel.xLine, in: [1, 4, 7])
            ||  checkForWinPossition(for: viewModel.oLine, in: [1, 4, 7])
        { x = -100 }
        else if checkForWinPossition(for: viewModel.xLine, in: [3, 6, 9])
            ||  checkForWinPossition(for: viewModel.oLine, in: [3, 6, 9])
        { x = 100 }
        
        return x
    }
    
    private  var victoryLineAngle: Double {
        var degree: Double =  90
        
        if checkForWinPossition(for: viewModel.xLine, in: [1, 2, 3])
            ||  checkForWinPossition(for: viewModel.xLine, in: [4, 5, 6])
            ||  checkForWinPossition(for: viewModel.xLine, in: [7, 8, 9])
            ||  checkForWinPossition(for: viewModel.oLine, in: [1, 2, 3])
            ||  checkForWinPossition(for: viewModel.oLine, in: [4, 5, 6])
            ||  checkForWinPossition(for: viewModel.oLine, in: [7, 8, 9])
        { degree = 90; viewModel.endGame = true}
        else  if checkForWinPossition(for: viewModel.xLine, in: [1, 4, 7])
            ||  checkForWinPossition(for: viewModel.xLine, in:  [2, 5, 8])
            ||  checkForWinPossition(for: viewModel.xLine, in: [3, 6, 9])
            ||  checkForWinPossition(for: viewModel.oLine, in: [1, 4, 7])
            ||  checkForWinPossition(for: viewModel.oLine, in:  [2, 5, 8])
            ||  checkForWinPossition(for: viewModel.oLine, in: [3, 6, 9])
        { degree = 180; viewModel.endGame = true } else if checkForWinPossition(for: viewModel.xLine, in: [1, 5, 9])
            ||  checkForWinPossition(for: viewModel.oLine, in: [1, 5, 9])
        { degree = 135; viewModel.endGame = true } else if checkForWinPossition(for: viewModel.xLine, in: [3, 5, 7])
            ||  checkForWinPossition(for: viewModel.oLine, in: [3, 5, 7])
        { degree = 225; viewModel.endGame = true  }
        
        return degree
    }
    
    private func checkForWinPossition(for side: [Int], in array: [Int]) -> Bool {
        var newArray = [Int]()
           for i in array {
            if side.contains(i) && !newArray.contains(i) {
                newArray.append(i)
               }
           }
        return newArray.sorted() == array
    }
}

