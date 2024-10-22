//
//  Constants.swift
//  currency
//
//  Created by apple on 21/10/24.
//

import Foundation
import SwiftUICore
import UIKit

struct Constants {
    struct API {
        static let baseURL = "https://api.exchangerate-api.com/v4/latest/"
    }
    
    struct ErrorMessages {
        static let exchangeRateFetchFailure = "Failed to fetch exchange rate:"
        static let errorMessage = "An unknown error occurred"
        static let errorTitle = "Error"
        static let ok = "Ok"
        static let invalidAmount = "Invalid amount"
        static let networkError = "Network error occurred. Please try again."
        static let emptyResponse = "No response received from the API."
    }
    
    struct Currency {
        static let defaultAmount = "0.0"
        static let defaultBaseCurrency = "USD"
        static let defaultTargetCurrency = "SGD"
        static let availableCurrencies = ["USD", "SGD", "EUR", "JPY", "GBP"]
        static let defaultConvertedAmount = "0.0"
        static let USD = "USD"
        static let SGD = "SGD"
        static let EUR = "EUR"
        static let JPY = "JPY"
        static let GBP = "GBP"
        
    }
    
    struct CurrencyImage {
        static let usa = "usa"
        static let singapore = "singapore"
        static let europe = "europe"
        static let japan = "japan"
        static let uk = "uk"
        static let placeholder = "placeholder"
    }
    
    
    struct ViewLabels {
        static let title = "Currency Converter"
        static let subtitle = "Check live rates, set rate alerts, receive notifications and more."
        static let amountLabel = "Amount" // Ensure this is defined
        static let exchangeAmountLabel = "Exchange Amount"
        static let indicativeExchangeRateText = "Indicative Exchange Rate"
        static let backgroundColor = Color(UIColor.systemBackground)
        static let amountPlaceholder = "Enter amount"
        static let exchangeRateFormat = "1 %@ = %.2f %@"
        static let swapButtonImage = "arrow.up.arrow.down" // Use SF Symbols or a custom image
        static let dropButtonImage = "chevron-down" // Use SF Symbols or a custom image
        static let currencyImageSize: CGFloat = 40 // Fixed size for currency images
        static let cornerRadius: CGFloat = 8 // Corner radius for rounded corners
        static let swapButtonSize: CGFloat = 40 // Size for swap button image
        static let currencyPickerWidth: CGFloat = 200 // Width for currency picker
        static let pickerBackgroundColor = Color(UIColor.systemGray5) // Background color for picker
        static let currencyRowHeight: CGFloat = 40 // Height for currency row
        static let dividerWidth: CGFloat = 120 // Width for the divider
        static let dividerHeight: CGFloat = 1 // Height for the divider
        static let swapButtonFrameWidth: CGFloat = 44 // Width for swap button frame
        static let swapButtonFrameHeight: CGFloat = 44 // Height for swap button frame
        static let shadowRadius: CGFloat = 8
        
    }
    struct Spacing {
        static func verticalSpacing(height: CGFloat) -> CGFloat {
            return height * 0.02 // 2% of device height
        }
        
        static func bottomPadding(height: CGFloat) -> CGFloat {
            return height * 0.05 // 5% of device height
        }
        static func pickerHeight(height: CGFloat) -> CGFloat {
            return height * 0.4 // 40% of device height
        }
        
        static let labelSpacing: CGFloat = 3 // Spacing for labels
        static let exchangeRateSpacing: CGFloat = 6 // Spacing for exchange rate
        static let exchangeRatePadding: CGFloat = 20 // Padding for exchange rate label
        static let outerHorizontalPadding: CGFloat = 20 // Outer horizontal padding
        static let horizontalPadding: CGFloat = 10 // Horizontal padding for converter view
        static let menuPadding: CGFloat = 8 // Padding for menu
        static let imagePadding: CGFloat = 8 // Padding for image in currency row
        static let rowHorizontalPadding: CGFloat = 15 // Horizontal padding for currency row
        static let amountFieldWidth: CGFloat = 140 // Width for amount field
    }
    struct Colors {
        static let primaryColor = Color(red: 31/255, green: 34/255, blue: 97/255)
        static let pickerBackgroundColor = Color.white
        static let backgroundColor = Color(.systemGray6)
        static let gradientStartColor = Color.blue
        static let gradientEndColor = Color.green
        static let errorColor = Color.red
    }
    
    struct Fonts {
        static let bold = "Roboto-Bold"
        static let regular = "Roboto-Regular"
        static let medium = "Roboto-Medium"
    }
    
    
    struct Formatting {
        static let amountFormat = "%.2f"
    }
}
