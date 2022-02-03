//
//  DataService.swift
//  Futag
//
//  Created by Furkan Erdoğan on 2.02.2022.
//

import Foundation

import Foundation

struct Service {
    static let shared = Service()
    
    func fetchBlogData(completion: @escaping([Blog]) -> Void) {
        guard let url = URL(string: "https://www.futag.net/wp-json/iky/blog") else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {return}
            
            do {
                
                let blogData = try JSONDecoder().decode([Blog].self, from: data)
                
                DispatchQueue.main.async {
                    completion(blogData)
                }
                
            }catch {
                
                let error = error
                print("Debug: is error \(error.localizedDescription)")
                
            }
        }
        .resume()
    }
    
    func fetchEventData(completion: @escaping([Event]) -> Void) {
        guard let url = URL(string: "https://www.futag.net/wp-json/iky/etkinlikler") else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {return}
            
            do {
                
                let blogData = try JSONDecoder().decode([Event].self, from: data)
                
                DispatchQueue.main.async {
                    completion(blogData)
                }
                
            }catch {
                
                let error = error
                print("Debug: is error \(error.localizedDescription)")
                
            }
        }
        .resume()
    }
    
    func fetchAdData(completion: @escaping([MainAd]) -> Void) {
        guard let url = URL(string: "https://www.futag.net/wp-json/iky/ads") else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {return}
            
            do {
                
                let blogData = try JSONDecoder().decode([MainAd].self, from: data)
                
                DispatchQueue.main.async {
                    completion(blogData)
                }
                
            }catch {
                
                let error = error
                print("Debug: is error \(error.localizedDescription)")
                
            }
        }
        .resume()
    }
    
    func fetchPostData(completion: @escaping([Post]) -> Void) {
        guard let url = URL(string: "https://www.futag.net/wp-json/iky/posts") else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {return}
            
            do {
                
                let blogData = try JSONDecoder().decode([Post].self, from: data)
                
                DispatchQueue.main.async {
                    completion(blogData)
                }
                
            }catch {
                
                let error = error
                print("Debug: is error \(error.localizedDescription)")
                
            }
        }
        .resume()
    }
}
