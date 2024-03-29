//
//  PlaySound.swift
//  MyopiaSim
//
//  Created by Rivian Pratama on 20/02/24
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var sliderPosition: CGFloat = 0
    @State private var lastSliderPosition: CGFloat = 0
    @State private var sliderValue: Int = 0
    @State private var leftEye: Double = 0
    @State private var rightEye: Double = 0
    @State private var viewType = 0
    @State private var storyType = 0
    @State private var previousEyePower: CGFloat = 0
    @State private var opacityCard = 1
    @State private var blurRadius = 5
    @State private var isFlashing = false
    @State private var isCardShowed = true
    @State private var isPopUpVisible: Bool = false
    @State private var generatedName: String = ""
    @State private var generatedCloth: Int = 0
    @State private var previousName: String = ""
    @State private var audioPlayer: AVAudioPlayer?
    @State private var audioPlayer1: AVAudioPlayer?
    
    var body: some View {
        NavigationStack{
            ZStack{
                ZStack {
                    ZStack {
                        ZStack{
                            Image("\(getViewType(viewType: Double(viewType)))")
                                .resizable()
                                .scaledToFit()
                                .frame(width: calculateFrameWidth(), height: calculateFrameHeight())
                                .offset(x: 230, y: -180)
                                .padding()
                                .blur(radius:blurStrength())
                            NoisyImage(originalImage: Image("layerNoise"), noiseIntensity: 0.5, noiseParticleSize: 1)
                                .frame(width: 450, height: 450)
                                .offset(x:230,y:-180)
                                .opacity(Double(max(200 - sliderValue, 0)) / 200.0)
                            Text("\(generatedName)'s Eye View")
                                .font(Font(CustomFonts.custom1.font1(size: 25)))
                                .foregroundColor(.white)
                                .padding(.trailing, -500)
                                .padding(.leading, 35)
                                .padding(.top, -60)
                                .shadow(color: .black, radius: 2)
                            Text("LIVE")
                                .font(Font(CustomFonts2.custom2.font2(size: 30)))
                                .foregroundColor(.red)
                                .offset(x: 410, y: -315)
                                .padding()
                                .shadow(color: .black, radius: 2)
                                .opacity(isFlashing ? 1 : 0)
                                .onAppear {
                                    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                                        self.isFlashing.toggle()
                                    }
                                }
                            Text("Distance :")
                                .font(Font(CustomFonts.custom1.font1(size: 30)))
                                .foregroundColor(.white)
                                .offset(x: 105, y: -315)
                                .padding()
                                .shadow(color: .black, radius: 2)
                            Text("\(200 - sliderValue)cm")
                                .font(Font(CustomFonts.custom1.font1(size: 30)))
                                .foregroundColor(.white)
                                .offset(x: 260, y: -315)
                                .padding()
                                .shadow(color: .black, radius: 2)
                            Text(blurStrength() < 0 ? "CLEAR" : "BLUR")
                                .font(Font(CustomFonts.custom1.font1(size: 30)))
                                .foregroundColor(blurStrength() < 0 ? .green : .yellow)
                                .offset(x: (blurStrength() < 0 ? 62 : 50), y: -280)
                                .padding()
                                .shadow(color: .black, radius: 2)
                        }
                        Image("backgroundScreen")
                            .aspectRatio(contentMode: .fill)
                            .offset(y: -2)
                    }
                    
                    ZStack {
                        HStack{
                            ZStack{
                                Image("laurenSprite")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 450, height: 450)
                                    .offset(x: sliderPosition, y: 150)
                                Image("laurenCloth")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 450, height: 450)
                                    .hueRotation(.degrees(Double(generatedCloth)))
                                    .offset(x: sliderPosition, y: 150)
                            }
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        let newPosition = value.translation.width + lastSliderPosition
                                        sliderPosition = min(max(newPosition, 0), 750)
                                        sliderValue=Int((sliderPosition / 75) * 20)
                                    }
                                    .onEnded { value in
                                        lastSliderPosition = sliderPosition
                                    }
                            )
                            Spacer()
                            Spacer()
                            Spacer()
                        }
                    }
                    
                    HStack{
                        Spacer()
                        VStack{
                            Text("\(generatedName) has -\(String(format: "%.2f", leftEye)) left and -\(String(format: "%.2f", rightEye)) right eye prescription.\nI want to confirm at what distance they can see clearly.\nHelp me by moving them closer to the TV!\n\n~Doc Hubert")
                                .font(Font(CustomFonts3.custom3.font3(size: 22)))
                                .foregroundColor(.black)
                                .padding(.top, -300)
                                .padding(.leading, 225)
                                .padding(.trailing, 800)
                                .lineSpacing(5)
                        }
                        Spacer()
                    }

                    Image("tvSprite")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaledToFit()
                        .frame(width: 750, height: 750)
                        .offset(x: 475, y: 135)
                    HStack{
                        Spacer()
                        VStack{
                            Button(action: {
                                playButtonClick()
                                if viewType == 4 {
                                        viewType = 0
                                    } else {
                                        viewType += 1
                                    }
                            }) {
                                Image("changePicture")
                                    .scaledToFit()
                            }
                            Button(action: {
                                sliderValue = 0
                                sliderPosition = 0
                                lastSliderPosition = 0
                                storyType = 1
                                blurRadius = 1
                                opacityCard = 1
                                isCardShowed = true
                                generateRandomEyeValues()
                                generateRandomName()
                                generateRandomCloth()
                                playConfirmClick()
                            }) {
                                Image("confirmtoDoc")
                                    .scaledToFit()
                            }
                            .disabled(blurStrength() < 0 &&  blurStrength() > -0.25 ? false : true)
                            .saturation(blurStrength() < 0 &&  blurStrength() > -0.25 ? 1.0 : 0)
                        }
                        .padding(.top, 600)
                        .padding(.trailing, 120)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .blur(radius: (CGFloat(blurRadius)))
            
                ZStack(){
                    Image("blackOpacity")
                       
                        .opacity(0.6)
                        .ignoresSafeArea()
                    Image("dialogueBar")
                    ZStack{
                        VStack{
                            Spacer()
                            HStack{
                                Text(storyType == 0 ?  "Hello!" :  storyType == 1 ? "\(previousName) has \(getEyePowerText(previousEyePower: previousEyePower)) They can see clearly at \(String(format: "%.1f", 100/previousEyePower)) cm" : "")
                                    .font(Font(CustomFonts3.custom3.font3(size: 35)))
                                    .foregroundColor(.brown)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .padding(.leading,180)
                            Text(storyType == 0 ? "Hey there! I'm Doc Hubert, the eye expert in town! \nCould you lend me a hand and help me move \(generatedName)'s chair until they can see perfectly? I've got all the numbers on their eye dioptries, just need to double-check. Thanks a bunch!" :  storyType == 1 ? "Fantastic, thanks a bunch! But guess what? \nOur clinic is bustling with kids today, and now it's \(generatedName)'s turn! They're patiently waiting for their turn to get their vision checked. \nCan you do me a favor and lend a hand once more?" : "" )
                                .font(Font(CustomFonts3.custom3.font3(size: 30)))
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.black)
                                .padding(.leading, 180)
                                .padding(.trailing, 200)
                        }
                        .padding(.bottom, 210)
                        HStack{
                            Button(action: {
                                if isCardShowed {
                                    blurRadius = 0
                                    opacityCard = 0
                                    isCardShowed = false
                                }
                                playButtonClick()
                                previousName = generatedName
                                previousEyePower = eyePower()
                            }) {
                                Image("okayButton")
                                    .scaledToFit()
                                
                            }
                            NavigationLink(destination: OutroPage()) {
                                Image("tiredButton")
                                    .scaledToFit()
                            }
                            .onTapGesture {
                            }
                        }
                        .padding(.trailing, 610)
                        .padding(.top, 70)
                        .disabled(storyType != 1)
                        .opacity(storyType == 1 ? 1 : 0)
                    }
                }
                .opacity(Double(opacityCard))
                .onDisappear {
                    stopBackgroundMusic()
                }
                .onAppear(perform: {
                    playButtonClick()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                       playBackgroundMusic()
                                   }
                    generateRandomEyeValues()
                                    generateRandomName()
                    generateRandomCloth()
                })
                .onTapGesture {
                    if isCardShowed {
                        blurRadius = 0
                        opacityCard = 0
                        isCardShowed = false
                    }
                    previousName = generatedName
                    previousEyePower = eyePower()
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    func generateRandomName() {
        let girlNames = ["Abigail", "Kaitlyn", "Charlize", "Wendy", "Michelle", "Audrey", "Elizabeth", "Monica", "Evelyn"]
        
        if let randomName = girlNames.randomElement() {
            generatedName = randomName
        }
    }
    
    func generateRandomCloth() {
        let girlCloth = [0, 45, 90, 135, 180, 225, 270, 315, 360]
        
        if let randomCloth = girlCloth.randomElement() {
            generatedCloth = randomCloth
        }
    }
    
    func getEyePowerText(previousEyePower: Double) -> String {
        switch previousEyePower {
        case 0.25..<1.5:
            return "low myopia..."
        case 1.5..<6:
            return "moderate myopia!"
        case 6..<20:
            return "high myopia!!!"
        default:
            return "no"
        }
    }
    
    func getViewType(viewType: Double) -> String {
        switch viewType {
        case 1:
            return "liveView2"
        case 2:
            return "liveView3"
        case 3:
            return "liveView4"
        case 4:
            return "liveView5"
        default:
            return "liveView1"
        }
    }
    
    private func generateRandomEyeValues() {
          
        let leftEyeRange = stride(from: 0.75, through: 10.0, by: 0.25)
        let rightEyeRange = stride(from: 0.75, through: 10.0, by: 0.25)
            
            var shuffledLeftEyeValues = leftEyeRange.shuffled()
            var shuffledRightEyeValues = rightEyeRange.shuffled()
            
            let maxGap = 3.0
            while abs(shuffledLeftEyeValues[0] - shuffledRightEyeValues[0]) > maxGap {
                shuffledLeftEyeValues.shuffle()
                shuffledRightEyeValues.shuffle()
            }
            
            leftEye = Double(shuffledLeftEyeValues[0])
            rightEye = Double(shuffledRightEyeValues[0])
        }

    private func calculateFrameWidth() -> CGFloat {
        let minValue: CGFloat = 475
        let maxValue: CGFloat = 1800
        let progress = Double(sliderValue) / 400.0
        return minValue + (maxValue - minValue) * CGFloat(progress)
    }
    
    private func calculateFrameHeight() -> CGFloat {

        return calculateFrameWidth()
    }
    
    private func playBackgroundMusic() {
          guard let url = Bundle.main.url(forResource: "backSound", withExtension: "mp3") else {
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
    
    private func stopBackgroundMusic() {
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
    
    private func playConfirmClick() {
          guard let url = Bundle.main.url(forResource: "confirmClick", withExtension: "mp3") else {
              return
          }

          do {
              audioPlayer = try AVAudioPlayer(contentsOf: url)
              audioPlayer?.play()
          } catch {
              print("Error playing background music: \(error.localizedDescription)")
          }
      }
    
 
    
    private func blurStrength() -> CGFloat {
        let maxBlurStrength: CGFloat = calculateMaxBlurStrength()
        let zeroBlurInDistance = 100/eyePower()
        let blurRatio = maxBlurStrength / ( 200 - (zeroBlurInDistance))
        let blurStrength = ((200 - CGFloat(sliderValue) )-zeroBlurInDistance) * blurRatio
        return blurStrength
    }
    
    private func calculateMaxBlurStrength() -> CGFloat {

        let scalingFactor: CGFloat
        if eyePower() >= 0.25 && eyePower() < 1.5 {
            scalingFactor = 2
        } else if eyePower() >= 1.5 && eyePower() < 6 {
            scalingFactor = 5
        } else {
            scalingFactor = 7
        }
        return scalingFactor
    }
    
    
    
    private func eyePower() -> CGFloat {
        return ((CGFloat(leftEye) + CGFloat(rightEye)) / 2)
    }
}

    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }


struct NoisyImage: View {
    let originalImage: Image
    let noiseIntensity: Double
    let noiseParticleSize: CGFloat
    
    var body: some View {
        ZStack {
            originalImage
                .resizable()
                .scaledToFit()
                .blendMode(.multiply)
                .opacity(0.8)
            
            Image(uiImage: generateNoiseImage(size: CGSize(width: 650, height: 450), intensity: noiseIntensity, particleSize: noiseParticleSize))
                .resizable()
                .scaledToFit()
                .blendMode(.screen)
        }
    }
    
    
    private func generateNoiseImage(size: CGSize, intensity: Double, particleSize: CGFloat) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        
        let noiseImage = renderer.image { context in
            let cgContext = context.cgContext
            
            for x in stride(from: 0, to: Int(size.width), by: Int.Stride(Double(particleSize))) {
                for y in stride(from: 0, to: Int(size.height), by: Int(particleSize)) {
                    let noise = UInt8.random(in: 0...255)
                    let color = UIColor(white: CGFloat(noise) / 2048.0, alpha: 1.0)
                    color.setFill()
                    cgContext.fill(CGRect(x: x, y: y, width: Int(particleSize), height: Int(particleSize)))
                }
            }
        }
        
        return noiseImage
    }
}
