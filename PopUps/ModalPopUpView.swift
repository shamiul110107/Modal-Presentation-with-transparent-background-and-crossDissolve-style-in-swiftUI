//
//  ModalPopUpView.swift
//  PopUps
//
//  Created by sami on 26/2/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct ModalPopUpView: View {
    
    @State var value = 0.0
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    var body: some View {
        
        VStack(alignment: .center) {
            Circle().frame(width: 156, height: 156).foregroundColor(.gray).padding()
            Text("You are presenting modal view controller with SwiftUI.").lineLimit(nil).multilineTextAlignment(.center).padding()
            
            Button(action: {
                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
            }) {
                Text("Dismiss")
            }.foregroundColor(.red).padding(.bottom)
            
        }.background(Color.white).clipShape(RoundedRectangle(cornerRadius: 3.0)).frame(width: UIScreen.main.bounds.size.width - 32)
            .shadow(radius: 3)
    }
}

struct ModalPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        ModalPopUpView()
    }
}
