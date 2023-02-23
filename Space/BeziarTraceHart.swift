//
//  BeziarTraceHart.swift
//  Space
//
//  Created by George Matiashvili on 20.02.23.
//

import SwiftUI
import PureSwiftUI

private let hartLayoutGuide = LayoutGuideConfig.grid(columns:16, rows: 20)
private typealias Curve = (p:CGPoint,cp1:CGPoint,cp2:CGPoint)

struct Hart:Shape{
    let debug:Bool
    //change with tag
    private var factor:CGFloat
    var animatableData: CGFloat{
        get{
            return factor
        }
        set{
            factor = newValue
        }
    }
    
    
    init(animating: Bool=false, debug: Bool = false) {
        self.debug = debug
        self.factor = animating ? 1 : 0
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let g = hartLayoutGuide.layout(in: rect)
        
        
        let p1 = g[0,6].to(g[2,6], factor)
        let p2 = g[8,4].to(g[8,5], factor)
        let p3 = g[16,6].to(g[14,6], factor)
        let p4 = g[8,20].to(g[8,19], factor)
        
        var curves = [Curve]()
        //c1
        curves.append(Curve(p2,g[0,0].to(g[3,2], factor),g[6,-2].to(g[7,2], factor)))
        //c2
        curves.append(Curve(p3,g[10,-2].to(g[9,2], factor),g[16,0].to(g[13,2], factor)))
        //c3
        curves.append(Curve(p4,g[16,10].to(g[15,12], factor),g[10,14]))
        //c4
        curves.append(Curve(p1,g[6,14],g[0,10].to(g[1,12], factor)))
        
        path.move(p1)
        
        for curve in curves{
            path.curve(curve.p, cp1: curve.cp1, cp2: curve.cp2,showControlPoints: debug)
        }
        
        return path
        
    }
    
    
}


struct BeziarTraceHart: View {
    @State private var animating = false
    var body: some View {
        VStack{
            Hart(animating: animating).fill(.red).frame(200)
            ZStack{
                Image("Hart")
                    .resizedToFit(200)
                Hart(animating: animating, debug:true)
                    .stroke(.black,lineWidth: 1)
                    .layoutGuide(hartLayoutGuide)
                    .frame(200)
            }
            .onAppear{
                withAnimation(Animation.easeOut(duration: 2.0).repeatForever(autoreverses: true)) {
                    self.animating = true
                }
            }
            
        }
    }
}

struct BeziarTraceHart_Previews: PreviewProvider {
    static var previews: some View {
        BeziarTraceHart()
            .showLayoutGuides(true)
            
    }
}
