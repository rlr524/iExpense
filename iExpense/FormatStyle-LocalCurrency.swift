//
//  FormatStyle-LocalCurrency.swift
//  iExpense
//
//  Created by Rob Ranf on 5/11/23.
//

import Foundation

extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Currency {
    static var localCurrency: Self {
        .currency(code: Locale.current.currencyCode ?? "USD")
    }
}
