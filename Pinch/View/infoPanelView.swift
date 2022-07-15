//
//  infoPanelView.swift
//  Pinch
//
//  Created by Furqan on 31/05/2022.
//

import SwiftUI

struct infoPanelView: View {
    var scale: CGFloat
    var offset: CGSize
    @State var completedLongPress:Bool = false
    var body: some View {
        HStack{
            Image(systemName:"circle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: 30, height: 30)
                .onLongPressGesture(minimumDuration:1)
               {
                    
                    withAnimation(.easeOut)
                    {
                        completedLongPress.toggle()
                    }
                }
            Spacer()
            
            HStack(spacing: 2) {
              Image(systemName: "arrow.up.left.and.arrow.down.right")
              Text("\(scale)")
              
              Spacer()
              
              Image(systemName: "arrow.left.and.right")
              Text("\(offset.width)")
              
              Spacer()
              
              Image(systemName: "arrow.up.and.down")
              Text("\(offset.height)")
              
              Spacer()
            }.font(.footnote)
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(8)
                .frame(maxWidth: 420)
                .opacity(completedLongPress ? 1 : 0)
           
          
        }
        
         
            
       
        
       
        
    }
}

struct infoPanelView_Previews: PreviewProvider {
    static var previews: some View {
        infoPanelView(scale: 1, offset: .zero).previewLayout(.sizeThatFits).padding().preferredColorScheme(.dark)
    }
}
