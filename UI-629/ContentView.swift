//
//  ContentView.swift
//  UI-629
//
//  Created by nyannyan0328 on 2022/08/03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            
            Home()
                .navigationTitle("Tool Bar Animation")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
