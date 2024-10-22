import XCTest
@testable import currency // Replace with your actual app module name

class CurrencyConverterViewModelTests: XCTestCase {
    var viewModel: CurrencyConverterViewModel!

    override func setUp() {
        super.setUp()
        // Initialize the view model before each test
        viewModel = CurrencyConverterViewModel()
    }

    override func tearDown() {
        // Clean up after each test
        viewModel = nil
        super.tearDown()
    }

    // Test for initial currency values
    func testInitialCurrencyValues() {
        XCTAssertEqual(viewModel.fromCurrency, "USD")
        XCTAssertEqual(viewModel.toCurrency, "SGD")
        XCTAssertEqual(viewModel.amount, "0.0")
    }

    // Test for currency conversion logic
    func testCurrencyConversion() {
        viewModel.amount = "100"
        viewModel.fromCurrency = "USD"
        viewModel.toCurrency = "EUR"
        viewModel.exchangeRate = 0.85
        
        viewModel.convertCurrency()

        XCTAssertEqual(viewModel.convertedAmountText, "85.00")
    }

    // Test for updating exchange rate
    func testUpdateExchangeRate() {
        // Set initial currencies and exchange rate
        viewModel.fromCurrency = "USD"
        viewModel.toCurrency = "EUR"
        viewModel.exchangeRate = 0.85
        
        viewModel.fetchExchangeRate()
        
        // Verify that exchange rate is updated
        XCTAssertNotNil(viewModel.exchangeRate)
        XCTAssertEqual(viewModel.exchangeRate, 0.85)
    }

    // Test for swapping currencies
    func testSwapCurrencies() {
        let originalFromCurrency = viewModel.fromCurrency
        let originalToCurrency = viewModel.toCurrency
        
        viewModel.swapCurrencies()
        
        XCTAssertEqual(viewModel.fromCurrency, originalToCurrency)
        XCTAssertEqual(viewModel.toCurrency, originalFromCurrency)
    }
}
