//
//  ContentView.swift
//  Chapter04
//
//  Created by Jose Marchena on 22/08/2020.
//

import SwiftUI

struct ContentView: View {
    typealias rectangleInfo = (color: Color, size: CGFloat)
    typealias AlignmentInfo = (label: String, value: VerticalAlignment)
    var data = [rectangleInfo(color: Color.red, size: 100),
                rectangleInfo(color: Color.green, size: 60),
                rectangleInfo(color: Color.blue, size: 80)]
    
    var alignmentData: [AlignmentInfo] = [("Top", VerticalAlignment.top), ("Center", VerticalAlignment.center), ("Bottom", VerticalAlignment.bottom)]
    
    @State var collapsed: Bool = false
    @State var alignment: Int = 1
    @State var spacing: Double = 8
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Toggle(isOn: $collapsed.animation(), label: {
                    Text("Collapsed")
                })
                Spacer()
            }
            
            SegmentedControl<VerticalAlignment>(values: alignmentData, selectedValue: $alignment.animation())
            
            CollapsibleHStack(data: data, collapsed: collapsed, alignment: alignmentData[alignment].value, spacing: CGFloat(spacing)) { element in
                Rectangle()
                    .fill(element.color)
                    .frame(width: element.size, height: element.size)
            }
            
            Slider(value: $spacing, in: 0...16, step: 1)
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
    var alignment: VerticalAlignment = .center
    var spacing: CGFloat?
    var content: (Element) -> Content

    var body: some View {
        HStack(alignment: alignment, spacing: spacing) {
            ForEach(data.indices) { idx in
                content(self.data[idx])
                    .frame(width: collapsed && idx < self.data.count - 1 ? 10 : nil, alignment: .leading)
            }
        }
    }
}

struct SegmentedControl<Element>: View {
    
    var values: [(label: String, value: Element)] = []
    @Binding var selectedValue: Int

    var body: some View {
        Picker("Alignment", selection: $selectedValue) {
            ForEach(0..<values.count) { index in
                Text(self.values[index].label).tag(index)
            }
        }.pickerStyle(SegmentedPickerStyle())
    }
}
