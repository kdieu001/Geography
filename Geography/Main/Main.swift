//
//  ContentView.swift
//  Geography
//
//  Created by Kevin Dieu on 10/10/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            
            if let countryList = viewModel.countryList {

                List(countryList) { country in
                    CountryCell(country: country)
                }
                .scrollContentBackground(.hidden)
                .opacity(0.7)
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            } else {
                VStack(alignment: .center) {
                    Text("Error")
                }
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [.white, .blue, .green]), startPoint: .top, endPoint: .bottom)
        )
        .onAppear(perform: {
            viewModel.setupData()
        })
        
    }
}

struct CountryCell: View {
    var country: Country
    
    init(country: Country) {
        self.country = country
    }
    
    var body: some View {
        VStack {
            HStack {
                Text((country.capital ?? "") + ", " + (country.name ?? ""))
                Spacer()
                Text(country.currency?.symbol ?? "")
            }
            HStack {
                Text(country.code ?? "")
                Spacer()
            }
        }
        
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView(viewModel: MainViewModel(urlString: "", countryList: countryList))
        
        ContentView(viewModel: MainViewModel(urlString: "", countryList: nil))

        CountryCell(country: countryList[0])
        
        
    }
    
    private static var countryList: [Country] {
        [
//            Country(capital: "Kabul", code: "AF", currency: Country.Currency.init(code: "AFN", name: "Afghan afghani", symbol: "؋"), flag: "https://restcountries.eu/data/afg.svg", language: Country.Language(code: "ps", name: "Pashto"), name: "Afghanistan", region: "AS"),
//            Country(capital: "Mariehamn", code: "AX", currency: Country.Currency.init(code: "EUR", name: "Euro", symbol: "€"), flag: "https://restcountries.eu/data/ala.svg", language: Country.Language(code: "sv", name: "Swedish"), name: "Åland Islands", region: "EU")
        ]
    }
}

