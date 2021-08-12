//
//  CoinModel.swift
//  Bitcoin Rate Live
//
//  Created by Jasur Salimov on 8/12/21.
//

import Foundation
struct CoinModel: Codable{
    
    
    var rate: Double
    
    init(r: Double){
        self.rate = r
        
    }
}
