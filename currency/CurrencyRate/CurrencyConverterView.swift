import SwiftUI

struct CurrencyConverterView: View {
    @StateObject private var viewModel = CurrencyConverterViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            
            VStack(spacing: Constants.Spacing.verticalSpacing(height: height)) {
                // Title and Subtitle
                Text(Constants.ViewLabels.title)
                    .font(.custom(Constants.Fonts.bold, size: 25))
                    .fontWeight(.bold)
                    .foregroundColor(Constants.Colors.primaryColor)
                    .padding(.horizontal, Constants.Spacing.outerHorizontalPadding)
                
                Text(Constants.ViewLabels.subtitle)
                    .font(.custom(Constants.Fonts.regular, size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(UIColor.secondaryLabel))
                    .padding(.horizontal)
                    .padding(.bottom, Constants.Spacing.bottomPadding(height: height))
                
                // Currency Picker Sections
                VStack(spacing: Constants.Spacing.verticalSpacing(height: height)) {
                    currencyPickerSection(
                        currency: $viewModel.fromCurrency,
                        amount: $viewModel.amount,
                        isEditable: true,
                        label: Constants.ViewLabels.amountLabel
                    )
                    
                    swapSection() // Swap section between currency pickers
                    
                    currencyPickerSection(
                        currency: $viewModel.toCurrency,
                        amount: .constant(viewModel.convertedAmountText),
                        isEditable: false,
                        label: Constants.ViewLabels.exchangeAmountLabel
                    )
                }
                .padding(.vertical)
                .background(
                    RoundedRectangle(cornerRadius: Constants.ViewLabels.cornerRadius)
                        .fill(Constants.Colors.pickerBackgroundColor)
                        .shadow(radius: Constants.ViewLabels.shadowRadius)
                        .frame(height: Constants.Spacing.pickerHeight(height: height))
                )
                .padding(.horizontal, Constants.Spacing.horizontalPadding)
                .padding(.bottom, Constants.Spacing.bottomPadding(height: height))
                
                VStack(alignment: .leading, spacing: Constants.Spacing.exchangeRateSpacing) {
                    Text(Constants.ViewLabels.indicativeExchangeRateText)
                        .font(.custom(Constants.Fonts.regular, size: 16))
                        .foregroundColor(Color(UIColor.secondaryLabel))
                    
                    Text(String(format: Constants.ViewLabels.exchangeRateFormat, viewModel.fromCurrency, viewModel.exchangeRate ?? 0.0, viewModel.toCurrency))
                        .font(.custom(Constants.Fonts.medium, size: 18))
                        .foregroundColor(.primary)
                }
                .padding(.horizontal, Constants.Spacing.outerHorizontalPadding)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text(Constants.ErrorMessages.errorTitle),
                    message: Text(viewModel.errorMessage ?? Constants.ErrorMessages.errorMessage),
                    dismissButton: .default(Text(Constants.ErrorMessages.ok))
                )
            }
            .padding(.horizontal, Constants.Spacing.outerHorizontalPadding)
            .background(Constants.ViewLabels.backgroundColor.edgesIgnoringSafeArea(.all))
        }
    }
    
    // Currency Picker Section
    private func currencyPickerSection(currency: Binding<String>, amount: Binding<String>, isEditable: Bool, label: String) -> some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.labelSpacing) {
            Text(label)
                .font(.body)
                .foregroundColor(Color(UIColor.secondaryLabel))
                .padding(.horizontal)
            
            currencyRow(currency: currency, amount: amount, isEditable: isEditable)
                .padding(.vertical)
        }
    }
    
    // Currency Row
    private func currencyRow(currency: Binding<String>, amount: Binding<String>, isEditable: Bool) -> some View {
        HStack {
            Image(viewModel.currencyImage(for: currency.wrappedValue))
                .resizable()
                .frame(width: Constants.ViewLabels.currencyImageSize, height: Constants.ViewLabels.currencyImageSize)
                .clipShape(Circle())
                .padding(.trailing, Constants.Spacing.imagePadding)
            
            Menu {
                ForEach(viewModel.currencies, id: \.self) { currencyOption in
                    Button(action: {
                        currency.wrappedValue = currencyOption
                        viewModel.fetchExchangeRate()
                        viewModel.convertCurrency() // Convert after selecting currency
                    }) {
                        Text(currencyOption)
                            .foregroundColor(Constants.Colors.primaryColor)
                    }
                }
            } label: {
                HStack(spacing: 0) {
                    Text(currency.wrappedValue)
                        .foregroundColor(Constants.Colors.primaryColor)
                        .background(Constants.Colors.pickerBackgroundColor)
                        .cornerRadius(Constants.ViewLabels.cornerRadius)
                    
                    Image(Constants.ViewLabels.dropButtonImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(Constants.Colors.primaryColor)
                }
            }
            
            Spacer()
            TextField(Constants.ViewLabels.amountPlaceholder, text: amount)
                .disabled(!isEditable)
                .keyboardType(.decimalPad)
                .padding()
                .background(Constants.Colors.backgroundColor)
                .cornerRadius(Constants.ViewLabels.cornerRadius)
                .frame(maxWidth: Constants.Spacing.amountFieldWidth)
                .multilineTextAlignment(.trailing)
                .onChange(of: amount.wrappedValue) { _ in
                    // Optionally, you can call fetchExchangeRate() here
                }
        }
        .padding(.horizontal, Constants.Spacing.rowHorizontalPadding)
    }
    
    // Swap Section
    private func swapSection() -> some View {
        HStack {
            Divider()
                .frame(width: Constants.ViewLabels.dividerWidth, height: Constants.ViewLabels.dividerHeight)
                .background(Color.gray.opacity(0.5))
            
            Button(action: {
                viewModel.fetchExchangeRate() // Fetch the new exchange rate
                viewModel.convertCurrency() // Convert the amount after swapping
            }) {
                Image(systemName: Constants.ViewLabels.swapButtonImage)
                    .scaledToFit()
                    .frame(width: Constants.ViewLabels.swapButtonSize, height: Constants.ViewLabels.swapButtonSize)
                    .foregroundColor(.white)
                    .background(Circle().fill(Constants.Colors.primaryColor))
            }
            
            Divider()
                .frame(width: Constants.ViewLabels.dividerWidth, height: Constants.ViewLabels.dividerHeight)
                .background(Color.gray.opacity(0.5))
        }
    }
}
