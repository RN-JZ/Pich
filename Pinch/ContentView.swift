//
//  Created by Robert Petras
//  Credo Academy ♥ Design and Code
//  https://credo.academy
//

import SwiftUI

struct ContentView: View
{
  // MARK: - PROPERTY
  
  @State private var isAnimating: Bool = false
  @State private var imageScale: CGFloat = 1
  @State private var imageOffset: CGSize = .zero
  @State private var isDrawerOpen: Bool = false
  
  @State private var pageIndex: Int = 1
    
    let pages=pageData
  
  // MARK: - FUNCTION
  
  func resetImageState() {
    return withAnimation(.spring()) {
      imageScale = 1
      imageOffset = .zero
    }
  }
    func PageIndex()->String{
        return pages[pageIndex-1].imageName
    }
  
  // MARK: - CONTENT
  
  var body: some View
{
    NavigationView
    {
        ZStack
        {
            Color.clear
            
            // MARK: - PAGE IMAGE
            Image(PageIndex())
              .resizable()
              .aspectRatio(contentMode: .fit)
              .cornerRadius(10)
              .padding()
              .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
              .opacity(isAnimating ? 1 : 0)
              .animation(.linear(duration: 1), value: isAnimating)
              .offset(x: imageOffset.width, y: imageOffset.height)
              .scaleEffect(imageScale)
            // MARK: - 1. TAP GESTURE
              .onTapGesture(count: 2, perform: {
                if imageScale == 1 {
                  withAnimation(.spring()) {
                    imageScale = 5
                  }
                } else {
                  resetImageState()
                }
              })
            // MARK: - 2. DRAG GESTURE
              .gesture(
                DragGesture()
                  .onChanged { value in
                    withAnimation(.linear(duration: 1)) {
                      imageOffset = value.translation
                    }
                  }
                  .onEnded { _ in
                    if imageScale <= 1 {
                      resetImageState()
                    }
                  }
              )
            // MARK: - 3. MAGNIFICATION
              .gesture(
                MagnificationGesture()
                  .onChanged { value in
                    withAnimation(.linear(duration: 1)) {
                      if imageScale >= 1 && imageScale <= 5 {
                        imageScale = value
                      } else if imageScale > 5 {
                        imageScale = 5
                      }
                    }
                  }
                  .onEnded { _ in
                    if imageScale > 5 {
                      imageScale = 5
                    } else if imageScale <= 1 {
                      resetImageState()
                    }
                  }
              )
          } //: ZSTACK
        .navigationTitle("Pinch & Zoom")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
          isAnimating = true
        })
        // MARK: - INFO PANEL
        .overlay(
          infoPanelView(scale: imageScale, offset: imageOffset)
            .padding(.horizontal)
            .padding(.top, 30)
          , alignment: .top
        )
        // MARK: - CONTROLS
        
        .overlay(
            Group{
                HStack{
                    //SCALE DOWN
                    Button
                    {
                        withAnimation(.spring())
                        {
                            if imageScale>1{
                                imageScale-=1
                            }
                            else if imageScale<=1
                            {
                                resetImageState()
                            }
                        }
                    }label: {
                        ControlImageView(icon: "minus.magnifyingglass")
                    }
                    //RESET
                    
                    Button
                    {
                        resetImageState()
                    }label: {
                        ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                    }
                    
                    
                    //SCALE UP
                    Button
                    {
                        if imageScale<5
                        {
                            imageScale+=1
                        }else if imageScale>=5{
                            imageScale=5
                        }
                        
                    }label: {
                        ControlImageView(icon: "plus.magnifyingglass")
                    }
                    
                    
                    
                    
                }.padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .opacity(isAnimating ?1:0)
                
            }.padding(.bottom,30)
            ,alignment: .bottom
        )//MARK:CONTROLL ended
        
        
        //MARK:DRAWER
        .overlay(
            HStack{
                Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left")
                    .resizable()
                    .scaledToFit()
                    .frame(height:40)
                    .padding(8)
                    .foregroundStyle(.secondary)
                    .onTapGesture(perform:{
                        withAnimation(.easeOut)
                        {
                            isDrawerOpen.toggle()
                        }
                    })
                
                Spacer()
                
                ForEach(pages)
                {value in Image(value.thum).resizable().scaledToFit().frame(width:80)
                        .cornerRadius(8)
                        .shadow(radius: 4)
                    
                }
                
            }//HSTACK
                .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                .frame(width:260)
                .padding(.top,UIScreen.main.bounds.height/12)//main.bound.height//GIVE YOU EXACT SCREEN SIZE
                .offset(x:isDrawerOpen ? 20 : 215)
            ,alignment: .topTrailing
        )
        
           
       
    
    }.navigationViewStyle(.stack)

        
   }
}


// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
      ContentView()
      .preferredColorScheme(.dark)
      .previewDevice("iPhone 13")
  }
}

