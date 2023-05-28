//
//  NetworkManager.swift
//  H4X0R News
//
//  Created by Marco Lucio Sosa on 2/5/23.
//

import Foundation

// Object in charge of managing the network task. Saves individual posts into a posts property, which is later used for it's display.

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()
    
    func fetchData() {
        // URL is saved, session is initialized and data task is configured
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                // If there's no errors, initialize a JSON decoder
                if error == nil {
                    let decoder = JSONDecoder()
                    // If there's data, decode and save it into results constant. This contains all the results from the web.
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Results.self, from: safeData)
                            // Save all the posts into the declared posts array
                            // ALL updates to the main thread must use dispatchqueue method, since having it in the background will result in error
                            DispatchQueue.main.async {
                                self.posts = results.hits
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            // Actually begin the network task, as everything before was just it's configuration
            task.resume()
        }
    }
}
