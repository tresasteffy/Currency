import Foundation
import Combine

enum APIType {
    case exchangeRate(base: String)

    var url: URL? {
        switch self {
        case .exchangeRate(let base):
            return URL(string: "https://api.exchangerate-api.com/v4/latest/\(base)")
        }
    }
}

protocol APIClientProtocol {
    func fetch<T: Decodable>(apiType: APIType) -> AnyPublisher<Result<T, Error>, Never>
}

class APIClient: APIClientProtocol {
    private let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func fetch<T: Decodable>(apiType: APIType) -> AnyPublisher<Result<T, Error>, Never> {
        guard let url = apiType.url else {
            return Just(.failure(CustomError.invalidURL)).eraseToAnyPublisher()
        }

        return urlSession.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .map { .success($0) }
            .catch { error -> Just<Result<T, Error>> in
                // Handle specific error types
                if let urlError = error as? URLError {
                    return Just(.failure(CustomError.networkError(urlError.localizedDescription)))
                }
                return Just(.failure(CustomError.genericError(error.localizedDescription)))
            }
            .eraseToAnyPublisher()
    }
}

enum CustomError: Error {
    case invalidURL
    case networkError(String)
    case genericError(String)

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "The provided URL is invalid."
        case .networkError(let message):
            return "Network error: \(message)"
        case .genericError(let message):
            return "An error occurred: \(message)"
        }
    }
}
