//
//  Home.swift
//  UI-629
//
//  Created by nyannyan0328 on 2022/08/03.
//

import SwiftUI

struct Home: View {
    @State var tools: [Tool] = [
               .init(icon: "scribble.variable", name: "Scribble", color: .purple),
               .init(icon: "lasso", name: "Lasso", color: .green),
               .init(icon: "plus.bubble", name: "Comment", color: .blue),
               .init(icon: "bubbles.and.sparkles.fill", name: "Enhance", color: .orange),
               .init(icon: "paintbrush.pointed.fill", name: "Picker", color: .pink),
               .init(icon: "rotate.3d", name: "Rotate", color: .indigo),
               .init(icon: "gear.badge.questionmark", name: "Settings", color: .yellow)
           ]
    @State var activeTool : Tool?
    @State var startedToolPostion : CGRect = .zero
    var body: some View {
        VStack{
            
            VStack(alignment: .leading) {
                
                
                ForEach($tools){$tool in
                    
                    ToolView(tool: $tool)
                    
                    
                }
            
                
            }
            .padding(.horizontal,10)
            .padding(.vertical,12)
            .background{
             
                RoundedRectangle(cornerRadius: 10,style: .continuous)
                    .fill(.white.opacity(0.3).shadow(.drop(color:.black,radius: 5,x: 5,y: 5)).shadow(.drop(color:.white,radius: 5,x: 5,y: 5)))
                 .frame(width: 65)
                .frame(maxWidth: .infinity,alignment: .leading)
            }
            
            .coordinateSpace(name: "AREA")
            .gesture(
            
            DragGesture(minimumDistance: 0)
                .onChanged({ value in
                    
                    guard let firstPostion = tools.first else{return}
                    
                    if startedToolPostion == .zero{
                        
                        startedToolPostion = firstPostion.toolPostion
                    }
                    
                    let location = CGPoint(x: startedToolPostion.midX, y: value.location.y)
                    
                    if let index = tools.firstIndex(where: { tool in
                        
                        tool.toolPostion.contains(location)
                    }),activeTool?.id != tools[index].id{
                        
                        
                        withAnimation(.interpolatingSpring(stiffness: 220, damping: 9)){
                            
                            activeTool = tools[index]
                        }
                        
                    }
                    
                    
                    
                })
                .onEnded({ value in
                    
                    activeTool = nil
                    startedToolPostion = .zero
                })
            )
            
        }
        .padding(15)
        .padding(.top)
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .topLeading)
    }
    @ViewBuilder
    func ToolView(tool : Binding<Tool>) -> some View{
        
        HStack{
            
            Image(systemName: tool.icon.wrappedValue)
                .font(.title2)
                .frame(width: 45,height: 45)
                .background{
                 
                    
                    GeometryReader{proxy in
                        
                        let frame = proxy.frame(in: .named("AREA"))
                        
                        Color.clear
                            .preference(key : RectKey.self, value: frame)
                            .onPreferenceChange(RectKey.self) { rect in
                                tool.wrappedValue.toolPostion = rect
                            }
                        
                        
                        
                    }
                }
            
            if activeTool?.id == tool.id{
                
                Text(tool.name.wrappedValue)
                    .padding(.trailing,15)
                    .foregroundColor(.white)
            }
             
        }
        .background{
         
            
            RoundedRectangle(cornerRadius: 10,style: .continuous)
                .fill(tool.wrappedValue.color.gradient)
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct RectKey : PreferenceKey{
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
