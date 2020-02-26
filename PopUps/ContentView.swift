//
//  ContentView.swift
//  PopUps
//
//  Created by sami on 25/2/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct ViewControllerHolder {
    weak var value: UIViewController?
}

struct ViewControllerKey: EnvironmentKey {
    static var defaultValue: ViewControllerHolder {
        return ViewControllerHolder(value: UIApplication.shared.windows.first?.rootViewController)
        
    }
}

extension EnvironmentValues {
    var viewController: UIViewController? {
        get { return self[ViewControllerKey.self].value }
        set { self[ViewControllerKey.self].value = newValue }
    }
}

extension UIViewController {
    func present<Content: View>(style: UIModalPresentationStyle = .automatic, transitionStyle: UIModalTransitionStyle = .coverVertical, @ViewBuilder builder: () -> Content) {
        let toPresent = UIHostingController(rootView: AnyView(EmptyView()))
        toPresent.modalPresentationStyle = style
        toPresent.modalTransitionStyle = transitionStyle
        toPresent.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        toPresent.rootView = AnyView(
            builder()
                .environment(\.viewController, toPresent)
        )
        self.present(toPresent, animated: true, completion: nil)
    }
    
}

struct EtcView: View {
    var body: some View {
        VStack {
            List(0...100, id:\.self) { value in
                Text("do nothings")
            }
        }.background(Color.red)
    }
}

struct PopUpView: View {
    
    @State var value = 0.0
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        
        VStack(alignment: .center) {
            Circle().frame(width: 156, height: 156).foregroundColor(.gray).padding()
            Text("You are about to Restore Sami with 643 contacts.").lineLimit(nil).multilineTextAlignment(.center).padding()
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Confirm").padding(.leading, 15).padding(.trailing, 15)
            }.frame(height: 32).background(Color.orange).padding().foregroundColor(.white)
                        
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Continue")
            }.foregroundColor(.black).padding(.bottom)
        }.background(Color.green).clipShape(RoundedRectangle(cornerRadius: 3.0)).frame(width: UIScreen.main.bounds.size.width - 32)
    }
}

struct ContentView: View {
    
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    private var viewController: UIViewController? {
        self.viewControllerHolder
    }
    
    var body: some View {
        VStack {
            EtcView()
            Button(action: {
                self.viewController?.present(style: .overCurrentContext, transitionStyle: .crossDissolve) {
                    PopUpView()
                }
            }) {
                Text("Present me!")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpView()
    }
}
