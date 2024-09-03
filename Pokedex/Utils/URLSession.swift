//
//  URLSession.swift
//  MangaTCA
//
//  Created by mufkhalif on 26/08/24.
//

import Foundation

public extension URLSession {
    func get<T: Decodable>(url: URL, decodeResponseAs _: T.Type, decoder: JSONDecoder = AppUtil.decoder) async -> Result<T, AppError> {
        var request = URLRequest(url: url)

        let userAgent = "Hanami/\(AppUtil.version)"
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent")
        request.timeoutInterval = 15
        request.cachePolicy = .reloadIgnoringLocalCacheData

        let payload: Data
        let response: URLResponse

        do {
            (payload, response) = try await URLSession.shared.data(for: request)
        } catch {
            if let urlErr = error as? URLError {
                return .failure(.networkError(urlErr))
            } else {
                return .failure(.unknownError(error))
            }
        }

        guard let response = response as? HTTPURLResponse else {
            return .failure(.networkError(URLError(.unknown)))
        }

        guard (200 ..< 300).contains(response.statusCode) else {
            var userInfo: [String: Any] = [:]

            if let url = response.url {
                userInfo["url"] = url
            }

            return .failure(
                .networkError(
                    URLError(
                        URLError.Code(rawValue: response.statusCode),
                        userInfo: userInfo
                    )
                )
            )
        }

        do {
            return try .success(decoder.decode(T.self, from: payload))
        } catch {
            if let decodingError = error as? DecodingError {
                return .failure(.JSONDecodingError(decodingError))
            } else {
                return .failure(.unknownError(error))
            }
        }
    }
}
