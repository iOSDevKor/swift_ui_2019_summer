//
//  StopWatchView.swift
//  StopWatch
//
//  Copyright © 2019 keyWindow. All rights reserved.
//

import SwiftUI

struct StopWatchView: View {
    
    @ObservedObject var model: StopWatch
    @State private var isRunning: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
           
            Group {
                Text(model.userName).font(.title).foregroundColor(.blue) + Text("'s Stop Watch").font(.title)
            }.padding()
            
            Text(model.currentTime.formattedString)
                .foregroundColor(.red)
                .bold()
                .font(.largeTitle)
                .padding([.top, .bottom], 100)
            
            HStack {
                Spacer()
                Group {
                    if model.isPaused == false {
                        TitleWhiteFontButton(title: "LAP") {
                            self.model.addLap()
                        }.disabled(!isRunning)
                        .saturation(isRunning ? 1.0 : 0.1)
                    } else {
                        TitleWhiteFontButton(title: "RESET") {
                            self.model.reset()
                        }
                    }
                }.frame(width: 100, height: 100, alignment: .center)
                    .background(Color(red: 0.5,
                                      green: 0.5,
                                      blue: 0.5,
                                      opacity: isRunning || model.isPaused ? 1 : 0.5))
                .cornerRadius(50)
                    .padding()
                
                Spacer()
                
                Group {
                    if isRunning {
                        TitleWhiteFontButton(title: "STOP") {
                            self.model.stop()
                            self.isRunning.toggle()
                        }
                    } else {
                        TitleWhiteFontButton(title: "START") {
                            self.model.start()
                            self.isRunning.toggle()
                        }
                    }
                }.frame(width: 100, height: 100, alignment: .center)
                    .background(isRunning ? Color.red : Color.green)
                    .cornerRadius(50)
                    .padding()
                
                Spacer()
            }
            
            List(model.laps, id: \.self) { lap in
                HStack {
                    Text("Lap \(self.model.laps.count - self.model.laps.firstIndex(of: lap)!)")
                    Spacer()
                    Text(lap.formattedString)
                }
            }
        }
    }
}


struct TitleWhiteFontButton : View {
    
    var title: String
    var action: () -> ()
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.white)
                .font(.title)
        }
    }
}

#if DEBUG
struct StopWatchView_Previews: PreviewProvider {
    static var previews: some View {
        let model = StopWatch()
        return TabView {
            StopWatchView(model: model)
                .tabItem {
                    VStack {
                        Image(systemName: "stopwatch")
                        Text(model.userName)
                    }
            }
        }
    }
}
#endif
