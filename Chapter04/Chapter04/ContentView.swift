//
//  ContentView.swift
//  Chapter04
//
//  Created by Jose Marchena on 22/08/2020.
//

import SwiftUI

struct ContentView: View {
    typealias rectangleInfo = (color: Color, size: CGFloat)
    var data = [rectangleInfo(color: Color.red, size: 100),
                rectangleInfo(color: Color.green, size: 60),
                rectangleInfo(color: Color.blue, size: 80)]
    
    @State var collapsed: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Toggle(isOn: $collapsed.animation(), label: {
                    Text("Collapsed")
                })
                Spacer()
            }
            CollapsibleHStack(data: data, collapsed: collapsed) { element in
                Rectangle()
                    .fill(element.color)
                    .frame(width: element.size, height: element.size)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}


struct CollapsibleHStack<Element, Content: View>: View {
    var data: [Element]
    var collapsed: Bool = false
    var content: (Element) -> Content

    var body: some View {
        HStack {
            ForEach(data.indices) { idx in
                content(self.data[idx])
                    .frame(width: collapsed && idx < self.data.count - 1 ? 10 : nil, alignment: .leading)
            }
        }
    }
}
