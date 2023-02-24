//
//  AnimateCross.swift
//  Space
//
//  Created by George Matiashvili on 23.02.23.
// Final test for tags

import SwiftUI
import PureSwiftUI

private let crossLayoutConfig = LayoutGuideConfig.grid(columns: 3, rows: 3)
struct Cross:Shape{
    
    var animatableData: Double
    init(animating: Bool = false) {
        self.animatableData = animating ? 1 : 0
    }
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let g = crossLayoutConfig.layout(in: rect)
            .scaled(1/Double.pi)
            .rotated(360.degrees,factor: animatableData)
        
        for corner in 0..<4{
            
            let lg = g
                .rotated(90.degrees * corner)
                .xOffset(from: -rect.halfWidth, to: rect.halfWidth, factor: animatableData)
                .yScaled(from: 1/Double.pi, to: 1, factor: animatableData)
            
            
            if(corner == 0){
               path.move(lg.top)
            }
            path.line(lg[2,0])
            path.line(lg[3,0].to(lg[2,1],animatableData))
            path.line(lg[3,1])
            path.line(lg.trailing)
            
        }
        path.closeSubpath()
        
        return path
    }
    
    
}

struct AnimateCross: View {
    @State var animating:Bool = false
    var body: some View {
        VStack{
            Cross(animating: animating)
                .fill(animating ? .green : .red)
                .layoutGuide(crossLayoutConfig)
                .frame(200)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        animating.toggle()
                    }
                }
        }
        
    }
}

struct AnimateCross_Previews: PreviewProvider {
    static var previews: some View {
        AnimateCross()
            .preferredColorScheme(.dark)
            .showLayoutGuides(true)
    }
}
