//
//  ContentView.swift
//  ExRedacted
//
//  Created by 김종권 on 2022/10/31.
//

import SwiftUI

struct ContentView: View {
  @State var isLoading = true
  
  var body: some View {
    profileView
      .redacted(reason: isLoading ? .placeholder : [])
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
          self.isLoading = false
        }
      }
  }
  
  @ViewBuilder
  var profileView: some View {
    VStack {
      Image(systemName: "person.fill")
        .resizable()
        .frame(width: 50, height: 50)
        .foregroundColor(.black)
      Text("jake")
        .foregroundColor(.black)
      Button("Tap!") {
        print("Tap information")
      }
      .disabled(isLoading)
      Divider()
      MyView()
        .redacted(reason: .privacy)
      MyView()
        .redacted(reason: .someReason)
      MyView()
        .redacted(reason: .someReason2)
    }
  }
}

struct MyView: View {
  @Environment(\.redactionReasons) var redactionReasons

  var body: some View {
    if redactionReasons.contains(.privacy) {
      Text("This is privacy")
    } else if redactionReasons.contains(.someReason) {
      Text("This is someReason")
    } else if redactionReasons.contains(.someReason2) {
      Text("This is someReason2")
    } else {
      Text("This is public")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

extension RedactionReasons {
  static let someReason = RedactionReasons(rawValue: 1 << 2) // 4
  static let someReason2 = RedactionReasons(rawValue: 1 << 4) // 16
}
