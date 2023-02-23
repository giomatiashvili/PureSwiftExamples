//
//  AnimatingShapes.swift
//  Space
//
//  Created by George Matiashvili on 20.02.23.
//

import SwiftUI
import PureSwiftUI


private let sholderRatio = 0.65
private let arrowLayoutConfig = LayoutGuideConfig.grid(columns: [0,1-sholderRatio, sholderRatio,1], rows: 3)

struct Arrow2:Shape{
    
    private var factor:CGFloat
    var animatableData: CGFloat{
        get{
            return factor
        }
        set{
            factor = newValue
        }
    }
    
   
    init(isRight: Bool=false) {
        self.factor = isRight ? 0 : 1
    }
    func path(in rect: CGRect) -> Path {
        
        
        var path = Path()
        let g = arrowLayoutConfig.layout(in: rect)
        
       
        path.move(g[0,1].to(g[1,0], factor))
        path.line( g[2,1].to(g[1,1], factor))
        path.line(g[2,0].to(g[3,1], factor))
        path.line( g.trailing)
        path.line( g[2,3].to(g[3,2], factor))
        path.line(g[2,2].to(g[1,2], factor))
        path.line( g[0,2].to(g[1,3], factor))
        path.line( g.leading)
        path.closeSubpath()
        return path
    }
    
    
}


struct AnimatingShapes: View {
    @State var pointingRight = true
    var body: some View {
        Arrow2(isRight: pointingRight)
            .fill(.red)
            .frame(200,100)
            .layoutGuide(arrowLayoutConfig)
            .onTapGesture {
                withAnimation {
                    self.pointingRight.toggle()
                }
                
            }
    }
}


struct AnimatingShapes_Previews: PreviewProvider {
    static var previews: some View {
        AnimatingShapes().showLayoutGuides(true)
    }
}
