//
//  ContentView.swift
//  H4X0R News
//
//  Created by Marco Lucio Sosa on 2/3/23.
//

import SwiftUI

struct ContentView: View {
    // Creates instance of the network manager that is constantly updating (hence observedobject)
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        // Navigation View creates a "navigation controller" where multiple views occur with links
        NavigationView {
            // List object. Iterates through the array of post objects.
            List(networkManager.posts){ post in
                // Makes each "post" a link to it's web page through DetailView instance.
                NavigationLink(destination: WebView(urlString: post.url)) {
                    HStack {
                        VStack {
                            Text("⇧")
                            Text(String(post.points))
                        }
                        Divider()
                        
                        Text(post.title)
                    }
            
                }
            }
            .navigationTitle("hacker news")
        } // Initially, the posts array is empty. This will fetch posts which will then be showed on the news page. 
        .onAppear {
            self.networkManager.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


