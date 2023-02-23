//
//  AnimatingGreed.swift
//  Space
//
//  Created by George Matiashvili on 22.02.23.
//

import SwiftUI
import PureSwiftUI


private let mercedesLayoutConfig = LayoutGuideConfig.polar(rings: 1, segments: 3)

struct Mercedes:Shape{
    
    var animatableData: Double
    
    init(animating: Bool) {
        self.animatableData = animating ? 1 : 0
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
         var g = mercedesLayoutConfig.layout(in: rect)
            .rotated(360.degrees, factor: animatableData)
            .scaled(1 / Double.pi)
            .xOffset(from: -rect.halfWidth, to: rect.halfWidth, factor: animatableData)
        
        let transformedHeight = g.bottom.radiusTo(g.top)
        
        g = g.yOffset(-transformedHeight*0.5)
        
        
        path.line(from: rect.leading, to: rect.trailing)
        path.ellipse(g.center, .square(transformedHeight), anchor: .center)
        for segment in 0..<g.yCount{
            path.line(from: g.center, to: g[1,segment])
        }
        
        return path
    }
    
    
}


struct AnimatingGreed: View {
    @State var animating = false
    var body: some View {
        Mercedes(animating: animating)
            .stroke(.red)
            .layoutGuide(mercedesLayoutConfig)
            .frame(200)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.linear(duration: 0.5)) {
                    animating.toggle()
                }
            }
    }
}

struct AnimatingGreed_Previews: PreviewProvider {
    static var previews: some View {
        AnimatingGreed()
            .preferredColorScheme(.dark)
            .showLayoutGuides(true)
    }
}
