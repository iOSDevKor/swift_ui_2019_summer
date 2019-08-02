//
//  ContentView.swift
//  StopWatch
//
//  Copyright © 2019 keyWindow. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {

        let model = StopWatch()
        return TabView {
            StopWatchView(model: model).tabItem {
                VStack {
                    Image(systemName: "stopwatch")
                    Text("Stop Watch")
                }
            }
            
            SettingView(model: model).tabItem {
                VStack {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
