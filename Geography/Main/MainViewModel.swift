//
//  MainViewModel.swift
//  Geography
//
//  Created by Kevin Dieu on 10/10/22.
//

import Foundation
import Combine

extension Country: Identifiable {
    var id: String {
        code ?? UUID().uuidString
    }
}

enum MainViewModelError: Error {
    case invalidURL
    case genericError
}

class MainViewModel: ObservableObject {
    
    @Published var countryList: [Country]?
    var urlString: String
    var network: NetworkType
    var testing : Bool = false
    
    var apiNetwork: API
    var cancellables : Set<AnyCancellable> = []

    
    init(urlString: String, countryList: [Country]? = nil, network: NetworkType = NetworkService(), apiNetwork: API = APINetworkTwo()) {
        self.urlString = urlString
        self.countryList = countryList
        self.network = network
        self.apiNetwork = apiNetwork
    }
    
    func setupData(completion: ((Result<[Country], MainViewModelError>) -> Void)? = nil) {
        
        apiNetwork.execute(decodeType: [Country].self, urlString: urlString)
            .sink { result in
                switch result {
                case .finished:
                    print("finished")
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    print("error")

                }
            } receiveValue: { [weak self] countries in
                self?.countryList = countries
            }
            .store(in: &cancellables)
    }
}
