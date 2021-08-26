//
//  ContentView.swift
//  TicTacToe
//
//  Created by Камиль Сулейманов on 24.08.2021.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text("Score \n X \(viewModel.xScore) : \(viewModel.oScore) O")
                .bold()
                .multilineTextAlignment(.center)
            
            Text(viewModel.bannerText)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .frame(width: 200, height: 50)
                .background(Color.red.cornerRadius(15))
                .opacity(viewModel.endGame || viewModel.currentStep == 9 ? 1 : 0)
                .padding(.top, 30)
            
            Spacer()
            
            ZStack {
                LazyVGrid(columns: Array(repeating: GridItem(.fixed(100), spacing: 0), count: 3), spacing: 0){
                    ForEach(0..<viewModel.figures.count, id: \.self) { index in
                        Rectangle()
                            .fill(Color("SquareColor"))
                            .frame(width: 100, height: 100)
                            .overlay(Rectangle()
                                        .stroke(lineWidth: 3)
                                        .overlay(Image(systemName: viewModel.figures[index].figure)
                                                    .font(.largeTitle)
                                                    .foregroundColor(viewModel.figures[index].color)
                                                    .opacity(viewModel.figures[index].isHiden ? 0 : 1)))
                            .onTapGesture { viewModel.drawFigure(for: index) }
                    }
                }
                .overlay(Rectangle()
                            .stroke(lineWidth: 5)
                            .frame(width: 300, height: 300)
                            .foregroundColor(Color("SquareColor")))
            
                
                VictoryLine()
                    .environmentObject(viewModel)
            }
            .padding(.bottom, 30)
            
            
            Spacer()
            
            Image(systemName: "arrow.counterclockwise.circle")
                .font(.largeTitle)
                .foregroundColor(.black)
                .onTapGesture {
                    viewModel.resetGame(isResetButtonPressed: true)
                }
                .onLongPressGesture {
                    viewModel.resetGame(isResetButtonPressed: true)
                    viewModel.xScore = 0
                    viewModel.oScore = 0
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            
    }
}


