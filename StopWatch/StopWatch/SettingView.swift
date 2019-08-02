//
//  SettingView.swift
//  StopWatch
//
//  Copyright © 2019 keyWindow. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    
    @ObservedObject var model: StopWatch
    
    var body: some View {
        Form {
            TextField("User Name", text: $model.userName)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
        }
    }
}

#if DEBUG
struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(model: StopWatch())
    }
}
#endif
