//
//  ContentView.swift
//  MyOkashi
//
//  Created by 金城秀作 on 2021/02/16.
//
//  完成図
//　1.TextFieldでキーワードを入力。（例えば、〇〇味や商品名検索）
//　2.キーワードを含むお菓子の情報が取得される。
//　1の情報をWebAPIを利用して情報を送り結果を取得する仕組み。その後Listへセットする。

import SwiftUI


struct ContentView: View {
    
    // OkashiDataを参照する状態変数
    @ObservedObject var okashiDataList = OkashiData()
    // 入力された文字列を保持する状態変数
    @State var inputText = ""
    // SafariViewの表示を管理する変数
    @State var showSafari = false
    
    
    var body: some View {

        VStack {
            // 文字を受け取るTextFieldを表示する
            TextField("キーワードを入力してください", text: $inputText, onCommit: {
                // 入力完了直後に検索をする
                okashiDataList.searchOkashi(keyword:  inputText)
            })
            
            .padding()
            
            // リスト表示する
            List(okashiDataList.okashiList) { okashi in
                // 1つ１つの要素が取り出させれる
                
                Button(action: {
                    // SafariViewを表示する
                    showSafari.toggle()
                }) {
                    
                    HStack {
                        // Listの表示内容を生成する
                   　　 // 水平にレイアウト(横方向にレイアウト)
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
