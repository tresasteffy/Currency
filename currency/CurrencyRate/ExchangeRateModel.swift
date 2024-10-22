//
//  ExchangeRateModel.swift
//  currency
//
//  Created by apple on 21/10/24.
//

import Foundation
struct ExchangeRateResponse: Codable {
    let rates: [String: Double]
    let base: String
    let date: String
}
