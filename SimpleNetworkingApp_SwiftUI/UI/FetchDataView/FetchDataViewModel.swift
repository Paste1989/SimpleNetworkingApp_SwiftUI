//
//  FetchDataViewModel.swift
//  SimpleNetworkingApp_SwiftUI
//
//  Created by Saša Brezovac on 13.09.2023..
//

import Foundation
import SwiftUI

final class FetchDataViewModel: ObservableObject {
    @ObservedObject var networkinService = NetworkingService()
    @Published var textColor = Color.black
    
    @Published var showObject: Show?
    
    func reset() {
        textColor = .black
        showObject = nil
    }
}

//MARK: - Networking
extension FetchDataViewModel {
    ///fetch data - simple
    func fetchDataSimple() {
        let url = URL(string: "https://api.tvmaze.com/shows/1")!
        URLSession.shared.dataTask(with: url) { data, response, error in    ///networking framework, komunikacija sa serverom Http/s requests/ download/ upload
                                                                            ///tip taska, slanje i primanje podataka/  Data Form/ asinkrono/ background thread
            guard error == nil else {
                print("error")
                return
            }
            guard let data = data else { ///tip Data
                print("no data error")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(Show.self, from: data) ///klasa dekoder instanci iz JSON objekta, metoda dekodira instancu tocno definiranog tipa
                print(" -> Decoded data: \(decodedData)")
                DispatchQueue.main.async {
                    self.showObject = decodedData
                }
            }
            catch {
                print("Error: \(error)")
            }
        }.resume()          ///metoda URLSessionDataTaska/ pokreće task/ zove completion handler kad je task gotov
    }
    
    /// fetch data
    func fetchData() {
        let request = Request(
            path: "/shows/1",
            method: .get,
            type: .json,
            parameters: nil,
            query: nil)
    
        networkinService.fetch(with: request) { [weak self] result in
            switch result {
            case .success(let show):
                print("SUCCESS: \(show)")
                DispatchQueue.main.async {
                    self?.textColor = .green
                    self?.showObject = show
                }
            case .failure(let error):
                print("ERROR: \(error)")
                DispatchQueue.main.async {
                    self?.textColor = .red
                }
            }
        }
    }
}
  
