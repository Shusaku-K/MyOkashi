//
//  ContentView.swift
//  MyOkashi
//
//  Created by 金城秀作 on 2021/02/16.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var okashiDataList = OkashiData()
    
    
    @State var inputText = ""
    
    @State var showSafari = false
    
    
    var body: some View {

        VStack {
            TextField("キーワードを入力してください", text: $inputText, onCommit: {
                okashiDataList.searchOkashi(keyword:  inputText)
            })
            
            .padding()
            
            List(okashiDataList.okashiList) { okashi in
                
                
                Button(action: {
                    showSafari.toggle()
                }) {
                    
                    HStack {
                        Image(uiImage: okashi.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 40)
                        
                        
                        
                        Text(okashi.name)
                    }
                }
                
                .sheet(isPresented: self.$showSafari, content: {
                    SafariView(url: okashi.link)
                        .edgesIgnoringSafeArea(.bottom)
                })
            }
            
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
