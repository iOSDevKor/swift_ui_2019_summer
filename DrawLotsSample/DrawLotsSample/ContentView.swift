//
//  ContentView.swift
//  DrawLotsSample
//
//  Copyright © 2019 keyWindow. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model: Model
    
    var body: some View {
        NavigationView {
            List(model.numbers, id: \.self) { number in
                Text("\(number)").font(.title).bold()
            }
            .navigationBarItems(leading: Button(action: {
                self.model.reset()
            }) {
                Text("RESET")
                    .foregroundColor(.red)
                    .font(.title)
                }, trailing:
                Button(action: {
                    self.model.pick()
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.green)
                        .font(.title)
            })
                .navigationBarTitle(Text("추첨번호"), displayMode: .inline)
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            ContentView(model: Model())
            ContentView(model: Model())
        }
    }
}
#endif
