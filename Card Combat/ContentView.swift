//  ContentView.swift
//  Card Combat
//  Created by Elena Konsoula.

import SwiftUI

struct ContentView: View {
    
    @State private var playerCard = "back"
    @State private var cpuCard = "back"
    
    @State private var playerScore = 0
    @State private var cpuScore = 0
    
    @State private var rounds = 0
    @State private var gameOver = false
    
    var body: some View {
        
        ZStack{
            Image("background-plain")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            VStack{
                Spacer()
                Image("logo")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .padding()
                Spacer()
                
                HStack{
                    Spacer()
                    Image(playerCard)
                        .imageScale(.large)
                        .transition(.opacity)
                        .animation(.easeIn, value: playerCard)
                    Spacer()
                    Image(cpuCard)
                        .imageScale(.large)
                        .transition(.opacity)
                        .animation(.easeIn, value: cpuCard)
                    Spacer()
                }
                Spacer()
                
                //Deal Button
                Button{
                    deal()
                } label: {
                    Image("button")
                }
                .disabled(gameOver)//lock the button when game is over
                
                Button("Reset"){
                    resetGame()
                }
                .font(.title)
                .padding(8)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                //Round Indicator
                Text("Round \(rounds)/15")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top,1)
                
                //Messages
                if gameOver{
                    VStack{
                        Text("Game Over!")
                            .font(.title)
                            .foregroundColor(.yellow)
                            .padding(.top, 10)
                        if playerScore > cpuScore{
                            Text("You Win!")
                                .font(.title2)
                                .foregroundColor(.green)
                        } else if cpuScore > playerScore{
                            Text("CPU Wins!")
                                .font(.title2)
                                .foregroundColor(.red)
                        } else {
                            Text("It's a Tie!")
                                .font(.title2)
                                .foregroundColor(.blue)
                        }
                    }
                }
                
                Spacer()
                HStack{
                    Spacer()
                    VStack{
                        Text("Player")
                            .font(.headline)
                            .padding(.bottom, 10.0)
                        Text(String(playerScore))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    Spacer()
                    VStack{
                        Text("CPU")
                            .font(.headline)
                            .padding(.bottom, 10.0)
                        Text(String(cpuScore))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    Spacer()
                }
                .foregroundColor(.white)
                Spacer()
            }
        }
    }
    
    func deal(){
        guard !gameOver else {
            return
        }
        
        //Randomize the players card
        let playerCardValue = Int.random(in: 2...14)
        playerCard = "card" + String(playerCardValue)
        //Randomize the cpus card
        let cpuCardValue = Int.random(in: 2...14)
        cpuCard = "card" + String(cpuCardValue)
        
        //Update the scores
        if playerCardValue > cpuCardValue{
             playerScore += 1
        }
        else if playerCardValue < cpuCardValue{
            cpuScore += 1
        }
        
        rounds += 1
        if rounds >= 15{
            gameOver = true
        }
    }
    
    func resetGame(){
        playerScore = 0
        cpuScore = 0
        rounds = 0
        gameOver = false
        playerCard = "back"
        cpuCard = "back"
    }
}

#Preview {
    ContentView()
}
