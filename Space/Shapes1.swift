//
//  Shapes1.swift
//  Space
//
//  Created by George Matiashvili on 20.02.23.
//

import SwiftUI
import PureSwiftUI

private let sholderRatio = 0.65
private let innerRadiusRatio = 0.4
private let arrowLayoutConfig = LayoutGuideConfig.grid(columns: [0,sholderRatio,1], rows: 3)
private let starLayoutConfig = LayoutGuideConfig.polar(rings: [0,innerRadiusRatio,1] , segments: 10 )

struct Star:Shape{
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let g = starLayoutConfig.layout(in: rect)
        
         
        path.move(g[2,0])
        
        for segment in 1..<g.yCount{
            
            path.line(g[segment.isOdd ? 1 : 2, segment])
        }
        path.closeSubpath()
        
        return path
    }
    
    
}

struct Arrow:Shape{
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let g = arrowLayoutConfig.layout(in: rect)
        
        path.move(g[0,1])
        path.addLine(to: g[1,1])
        path.addLine(to: g[1,0])
        path.addLine(to: g.trailing)
        path.addLine(to: g[1,3])
        path.addLine(to: g[1,2])
        path.addLine(to: g[0,2])
        path.closeSubpath()
        return path
    }
    
    
}

struct Shapes1: View {
    var body: some View {
        VStack{
            Arrow()
                .stroke(.black)
                .layoutGuide(arrowLayoutConfig)
                .frame(200,100)
            Star()
                .stroke(.black)
                .layoutGuide(starLayoutConfig)
                .frame(200)
           
        }
    }
}

struct Shapes1_Previews: PreviewProvider {
    static var previews: some View {
        Shapes1()
            .showLayoutGuides(true)
    }
}
