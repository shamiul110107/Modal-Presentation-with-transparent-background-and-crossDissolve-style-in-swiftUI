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

struct ContentView: View {
    
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    
    var body: some View {
        VStack {
            List(0...20, id:\.self) { index in
                Text("Clicked on Row \(index+1)")
            }
        }.onTapGesture {
            self.viewControllerHolder?.present(style: .overCurrentContext, transitionStyle: .crossDissolve) {
                ModalPopUpView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
