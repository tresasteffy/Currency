import SwiftUI
import Combine

class CurrencyConverterViewModel: ObservableObject {
    @Published var amount: String = ""
    @Published var fromCurrency: String = Constants.Currency.defaultBaseCurrency
    @Published var toCurrency: String = Constants.Currency.defaultTargetCurrency
    @Published var convertedAmount: Double?
    @Published var exchangeRate: Double?
    @Published var errorMessage: String?
    @Published var showAlert: Bool = false

    private let apiClient: APIClientProtocol
    private var cancellables = Set<AnyCancellable>()

    let currencies = Constants.Currency.availableCurrencies

    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
        fetchExchangeRate()
    }

    func fetchExchangeRate() {
        apiClient.fetch(apiType: .exchangeRate(base: fromCurrency))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (result: Result<ExchangeRateResponse, Error>) in
                switch result {
                case .success(let response):
                    self?.exchangeRate = response.rates[self?.toCurrency ?? ""]
                case .failure(let error):
                    self?.errorMessage = "\(Constants.ErrorMessages.errorMessage) \(error.localizedDescription)"
                    self?.showAlert = true
                }
            }
            .store(in: &cancellables)
    }

    func convertCurrency() {
        guard let inputAmount = Double(amount), inputAmount > 0, let rate = exchangeRate else {
            if !amount.isEmpty {
                self.errorMessage = Constants.ErrorMessages.invalidAmount
                self.showAlert = true
            }
            convertedAmount = nil
            return
        }
        convertedAmount = inputAmount * rate
    }

  

    func currencyImage(for currency: String) -> String {
        switch currency {
        case Constants.Currency.USD: return Constants.CurrencyImage.usa
        case Constants.Currency.SGD: return Constants.CurrencyImage.singapore
        case Constants.Currency.EUR: return Constants.CurrencyImage.europe
        case Constants.Currency.JPY: return Constants.CurrencyImage.japan
        case Constants.Currency.GBP: return Constants.CurrencyImage.uk
        default: return Constants.CurrencyImage.placeholder
        }
    }

    var convertedAmountText: String {
        if let amount = convertedAmount {
            return String(format: Constants.Formatting.amountFormat, amount)
        } else {
            return Constants.Currency.defaultConvertedAmount
        }
    }
}
