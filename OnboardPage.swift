    //
    //  OnboardPage.swift
    //  MyopiaSim
    //
    //  Created by Rivian Pratama on 20/02/24
    //
    import SwiftUI

    struct OnboardPage: View {
        
        @State private var offset: CGFloat = 100
        @State private var opacity: CGFloat = 0

        var body: some View {
            NavigationView{
                ZStack {
                    Image("backgroundIntro")
                        .resizable()
                        .scaledToFill()
                        .aspectRatio(contentMode: .fill)
                        .offset(y: CGFloat(offset))
                        .opacity(opacity)
                        .animation(.easeIn(duration: 1), value: offset)
                        .animation(.easeIn(duration: 1), value: opacity)
                    
                    HStack {
                        VStack{
                            Text("MyopiaSim")
                                .font(Font(CustomFonts3.custom3.font3(size: 110)))
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.pink)
                                .padding(.bottom, 25)
                                .opacity(opacity)
                                .animation(.easeIn(duration: 2), value: opacity)
                            NavigationLink(destination: ContentView()) {
                                Image("PlayButton")
                                    .scaledToFit()
                                    .padding(.trailing, 145)
                                    .opacity(opacity)
                                    .animation(.easeIn(duration: 2), value: opacity)
                            }
        
                        }
                        .padding(.bottom, 500)
                        .padding(.leading, 50)
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        Text("Welcome to Beccasy City,\n where Doc Hubert, the friendly optometrist, works tirelessly in his bustling clinic. \n\nWith smartphones causing eye troubles\nfor kids and grown-ups alike, \nDr. Hubert needs your helps to\nease the eye-checks. \n\nEmbark on this adventure\nand let's bring back the sparkle to \nBeccasy's vision together!")
                            .font(Font(CustomFonts3.custom3.font3(size: 22)))
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.black)
                            .frame(width:450)
                            .opacity(opacity)
                            .animation(.easeIn(duration: 2), value: opacity)
                            .offset(y: -240)
                            .padding(.trailing, 50)
                            .onAppear(){
                                offset = -2
                                opacity = 1
                            }
                    }
                    VStack {
                        Spacer()
                                Text("Illustration created with Procreate & Figma, Music & SFX composed with Garageband, Stock image courtesy of Pixabay.")
                            .fontWeight(.medium)
                                    .padding()
                                    .foregroundColor(.black)
                                    .cornerRadius(10)
                                    .padding()
                                    .padding()
                                  
                            }
                }

            }
            .navigationViewStyle(.stack)
            .navigationBarHidden(true) 
        }
    }


    struct OnboardPage_Previews: PreviewProvider {
        static var previews: some View {
            OnboardPage()
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
