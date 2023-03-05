//
//  ConnectedWheels.swift
//  Space
//
//  Created by George Matiashvili on 04.03.23.
//

import SwiftUI
import PureSwiftUI


let wheelsLayoutConfig = LayoutGuideConfig.polar(rings: 2, segments: 6)

struct ConnectedWheel: Shape {
   
    private var factor:CGFloat
    var animatableData: CGFloat{
        get{
            factor
        }
        set{
            factor = newValue
        }
    }
    
    init(animating: Bool) {
        self.factor = animating ? 1 : 0
    }
    
    
    
    func path(in rect: CGRect) -> Path {
        let radius = rect.minDimension * 0.5
        let yOffser = rect.height * 0.5 - radius
        let gBase = wheelsLayoutConfig
            .rotated(360.degrees,factor: factor)
            .layout(in: rect)
        
        let g1 = gBase.yOffset(-yOffser)
        let g2 = gBase.yOffset(yOffser)
        
        let guides = [g1,g2]
        
        return Path { path in
            
            for g in guides{
                
                for segment in 0..<g.yCount{
                    path.line(from: g.center, to: g[2,segment])
                }
                
                path.ellipse(g.center,.square(g.rect.minDimension),anchor: .center)
                path.circle(g[1,1], radius: 10)
            }
            path.line(from: g1[1,1], to: g2[1,1])
        }
        
        
    }
}


struct ConnectedWheels: View {
    @State private var animating = false
    var body: some View {
        ConnectedWheel(animating: animating)
            .stroke(.white,lineWidth: 3)
            .frame(200,500)
            .layoutGuide(wheelsLayoutConfig)
            .border(Color.white(0.5).opacity(0.5))
            .greedyFrame()
            .ignoresSafeArea()
            .onAppear{
                withAnimation(Animation.linear(duration: 4).repeatForever(autoreverses: false)){
                    self.animating = true
                }
            }
    }
}

struct ConnectedWheels_Previews: PreviewProvider {
    static var previews: some View {
        ConnectedWheels().preferredColorScheme(.dark)
            .showLayoutGuides(true)
    }
}
