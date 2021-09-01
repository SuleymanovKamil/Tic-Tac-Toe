//
//  swift
//  TicTacToe
//
//  Created by Камиль Сулейманов on 25.08.2021.
//

import SwiftUI

class ViewModel: ObservableObject {
    
    var endGame = false
    var currentStep = 0
    var xLine = [Int]()
    var oLine = [Int]()
    
    @Published var xScore = 0
    @Published var oScore = 0
    
    var bannerText: String {
        let XWin = endGame && currentStep <= 9 && xLine.count > oLine.count
        let OWin = endGame && currentStep <= 9 && xLine.count == oLine.count
       
        if XWin {
            return "X WIN!"
        } else if OWin {
            return "O WIN!"
        } else if currentStep == 9 {
             resetGame(isResetButtonPressed: false)
            return "Draw!"
        } else {
            return ""
        }
        
    }
    @Published var figures = [
        Figure(id: 1, figure: "xmark"),
        Figure(id: 2, figure: "circle"),
        Figure(id: 3, figure: "xmark"),
        Figure(id: 4, figure: "circle"),
        Figure(id: 5, figure: "xmark"),
        Figure(id: 6, figure: "circle"),
        Figure(id: 7, figure: "xmark"),
        Figure(id: 8, figure: "circle"),
        Figure(id: 9, figure: "xmark")
    ]
    
    func resetGame(isResetButtonPressed: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + (isResetButtonPressed ? 0 : 2)) { [unowned self] in
            figures.indices.forEach{figures[$0].isHiden = true}
            currentStep = 0
            xLine.removeAll()
            oLine.removeAll()
            endGame = false
        }
    }
    
    func drawFigure(for index: Int) {
        if figures[index].isHiden && !endGame {
            currentStep += 1
         
            if  currentStep % 2 != 0 {
                xLine.append(figures[index].id)
            } else {
                oLine.append(figures[index].id)
            }
            figures[index].isHiden = false
            figures[index].figure = currentStep % 2 != 0 ? "xmark" : "circle"
            figures[index].color = currentStep % 2 != 0 ? Color.blue : Color.red
        }
    }
}

