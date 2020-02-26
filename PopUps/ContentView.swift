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
                Text("Swift UI is Really aswesome")
            }
        }.background(Color.red)
    }
}

struct PopUpView: View {
    
    @State var value = 0.0
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    var body: some View {
        
        VStack(alignment: .center) {
            Circle().frame(width: 156, height: 156).foregroundColor(.gray).padding()
            Text("You are presenting modal view controller with SwiftUI.")
                .lineLimit(nil)
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: {
               self.viewControllerHolder?.dismiss(animated: true, completion: nil)
            }) {
                Text("Dismiss")
            }.foregroundColor(.red)
                .padding(.bottom)
            
        }.background(Color.white).clipShape(RoundedRectangle(cornerRadius: 3.0)).frame(width: UIScreen.main.bounds.size.width - 32)
        .shadow(radius: 3)
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
