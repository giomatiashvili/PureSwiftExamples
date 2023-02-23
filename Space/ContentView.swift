//
//  ContentView.swift
//  Space
//
//  Created by George Matiashvili on 19.02.23.
//

import SwiftUI
import CoreGraphics




struct ContentView: View {
    private let gradient = LinearGradient(gradient: .init(colors: [Color.green, Color.blue]),
                                          startPoint: .bottomLeading,
                                          endPoint: .topTrailing
                                         )
    
    var body: some View {
        VStack {
            HStack{
                Image(systemName:"qrcode.viewfinder").foregroundColor(.accentColor)
                    .imageScale(.large)
                Spacer()
                Image(systemName:"person.circle").foregroundColor(.accentColor)
                    .imageScale(.large)
            }
            .padding(20)
            ZStack{
                Text("156")
                    .font(.title)
                    .fontWeight(.bold)
                    
                    
                
                
                Circle()
                    //.trim(from: 0,to: 0.6)
                    .stroke(gradient, style: StrokeStyle(lineWidth: 6, lineCap:.square))
                    
                    .blur(radius: 10)
                    
                    .overlay(content: {
                        
                        Circle()
                            //.trim(from: 0,to: 0.6)
                            .stroke(gradient, style: StrokeStyle(lineWidth: 2, lineCap:.square))
                            
                            
                    })
                    .padding(20)
                    
                
            }
            HStack{
                
            }

            Spacer()
            
              
            
            
        }
        .padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
