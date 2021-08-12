//
//  CoinManager.swift
//  Bitcoin Rate Live
//
//  Created by Jasur Salimov on 8/12/21.
//

import Foundation



protocol CoinManagerDelegate {
    
    func didUpdateCurrency(_ coinManager: CoinManager, coinModel: CoinModel)
}

struct CoinManager{
    var delegate: CoinManagerDelegate?
    var currencyArray: [String] = ["USD","EUR","GBP","CNY"]
    var uRL1 = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    var uRL2 = "?apikey=3604407D-7AB3-4276-A055-5EB52DB54A84"
    var currencyPicked: String = ""
    func parseJSON(_ coin: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinModel.self, from: coin)
            _ = CoinModel(r:decodedData.rate)
            return decodedData
        }catch{
            
            print("error")
            return nil
        }
    }
    
    mutating func pickerPicked(row: Int){
        self.currencyPicked = currencyArray[row]
        let finalURL = "\(uRL1)\(currencyArray[row])\(uRL2)"
        print(finalURL)
        performRequest(finalURL: finalURL)
        
    }
    
    func performRequest(finalURL: String){
        if let url = URL(string: finalURL){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    return
                }
                if let safeData = data{
                    if let coin = self.parseJSON(safeData){
                        self.delegate?.didUpdateCurrency(self, coinModel: coin)
                    }
                    else{}
                }
            }
            task.resume()
        }
    }
  
    
}
