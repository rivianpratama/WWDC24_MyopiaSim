//
//  OutroPage.swift
//  MyopiaSim
//
//  Created by Rivian Pratama on 20/02/24
//

import SwiftUI
import AVFoundation

struct OutroPage: View {
    @State private var audioPlayer: AVAudioPlayer?
    @State private var audioPlayer1: AVAudioPlayer?
    @State private var textOutro = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("MainPageOutro")
                    .aspectRatio(contentMode: .fill)
                    .offset(y: -2)
                VStack {
                    Spacer()
                    NavigationLink(destination: OnboardPage()) {
                        Image("returnToMenu")
                            .scaledToFit()
                            .padding(.bottom, 120)
                    }
                }
                Text("\(outroText(textOutro: Double(textOutro)))")
                    .font(Font(CustomFonts3.custom3.font3(size: 45)))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                    .frame(width:650)
                    .offset(x:115, y: -40)
                HStack{
                    Spacer()
                    Button(action: {
                        playButtonClick()
                        if textOutro == 3 {
                                textOutro = 0
                            } else {
                                textOutro += 1
                            }
                    }) {
                        Image("nextButton")
                            .padding(.trailing, 220)
                            .padding(.top, 350)
                    }
                }
            }
            .navigationBarHidden(true)
            .onAppear(){
                playButtonClick()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                   playOutroMusic()
                               }
            }
            .onDisappear(){
                stopOutroMusic()
                playButtonClick()
            }
        }
    }
        
    func outroText(textOutro: Double) -> String {
        switch textOutro {
        case 1:
            return "These days, lots of kids and even grown-ups are spending a lot of time on their smartphones, and it's taking a toll on their eyesight. They're keeping my clinic really busy every day!"
        case 2:
            return "I wish they'd spend more time outdoors, soaking up the sun and exploring the world around them. If things keep going this way, who knows, maybe none of the kids in the world will have perfect eyesight. "
        case 3:
            return "But hey, with your help,\nmaybe we can inspire a change, one pair of glasses at a time.\nHang in there, champ!"
        default:
            return "Hey there, friend!\nI see you've been lending me a hand in the clinic, and I can't thank you enough for your help.\nIt's tough, I know. "
        }
    }
    
    private func playOutroMusic() {
          guard let url = Bundle.main.url(forResource: "outroSound", withExtension: "mp3") else {
              return
          }

          do {
              audioPlayer1 = try AVAudioPlayer(contentsOf: url)
              audioPlayer1?.numberOfLoops = -1
              audioPlayer1?.play()
          } catch {
              print("Error playing background music: \(error.localizedDescription)")
          }
      }
    
    private func stopOutroMusic() {
           audioPlayer1?.stop()
       }
    
    private func playButtonClick() {
          guard let url = Bundle.main.url(forResource: "buttonClick", withExtension: "mp3") else {
              return
          }

          do {
              audioPlayer = try AVAudioPlayer(contentsOf: url)
              audioPlayer?.play()
          } catch {
              print("Error playing background music: \(error.localizedDescription)")
          }
      }
    
}

struct OutroPage_Previews: PreviewProvider {
    static var previews: some View {
        OutroPage()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
