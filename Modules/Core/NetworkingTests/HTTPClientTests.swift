//
//  HTTPClientTests.swift
//  NetworkingTests
//
//  Created by Rahmat Trinanda Pramudya Amar on 22/01/26.
//

import XCTest
@testable import Networking

final class HTTPClientTests: XCTestCase {
    private var client: HTTPClient!
    private var session: MockSessionHTTP!
    private var decoder: MockResponseDecoder!

    override func setUp() {
        super.setUp()
        session = MockSessionHTTP()
        decoder = MockResponseDecoder()
        client = DefaultHTTPClient(
            baseURL: "https://test.com",
            session: session,
            decoder: decoder,
        )
    }

    override func tearDown() {
        client = nil
        session = nil
        decoder = nil
        super.tearDown()
    }

    // MARK: - Success

    func test_send_success_returnsDecodedModel() async throws {
        let expected = MockResponse(id: 1, title: "Movie")

        decoder.decodedObject = expected

        session.result = .success(
            Data("{}".utf8),
            HTTPURLResponse(
                url: URL(string: "https://test.com")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
        )

        let request = HTTPRequest(
            path: "/test",
            method: .get
        )

        do {
            let result: MockResponse = try await client.send(request)
            XCTAssertEqual(result, expected)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    // MARK: - Transport Error

    func test_send_transportError_throwsNetworkError() async {
        let transportError = URLError(.notConnectedToInternet)
        session.result = .failure(transportError)

        let request = HTTPRequest(path: "/test", method: .get)

        do {
            let _: MockResponse = try await client.send(request)
            XCTFail("Expected error")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .transportError(transportError))
        } catch {
            XCTFail("Unexpected error type")
        }
    }

    // MARK: - Non HTTP Response

    func test_send_nonHTTPResponse_throwsError() async {
        session.result = .success(
            Data(),
            URLResponse(
                url: URL(string: "https://test.com")!,
                mimeType: nil,
                expectedContentLength: 0,
                textEncodingName: nil
            )
        )

        let request = HTTPRequest(path: "/test", method: .get)

        await assertNetworkError(.nonHTTPResponse) {
            let _: MockResponse = try await client.send(request)
        }
    }

    // MARK: - HTTP Status Error

    func test_send_httpErrorStatusCode_throwsError() async {
        session.result = .success(
            Data("error".utf8),
            HTTPURLResponse(
                url: URL(string: "https://test.com")!,
                statusCode: 401,
                httpVersion: nil,
                headerFields: nil
            )!
        )

        let request = HTTPRequest(path: "/test", method: .get)

        await assertNetworkError(.httpError(statusCode: 401, data: Data("error".utf8))) {
            let _: MockResponse = try await client.send(request)
        }
    }

    // MARK: - Empty Response

    func test_send_emptyResponse_throwsError() async {
        session.result = .success(
            Data(),
            HTTPURLResponse(
                url: URL(string: "https://test.com")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
        )

        let request = HTTPRequest(path: "/test", method: .get)

        await assertNetworkError(.emptyResponse) {
            let _: MockResponse = try await client.send(request)
        }
    }

    // MARK: - Decoding Error

    func test_send_decodingError_throwsError() async {
        decoder.error = DecodingError.dataCorrupted(
            .init(codingPath: [], debugDescription: "Invalid JSON")
        )

        session.result = .success(
            Data("{}".utf8),
            HTTPURLResponse(
                url: URL(string: "https://test.com")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
        )

        let request = HTTPRequest(path: "/test", method: .get)

        do {
            let _: MockResponse = try await client.send(request)
            XCTFail("Expected decoding error")
        } catch let error as NetworkError {
            if case .decodingFailed = error {
                XCTAssertTrue(true)
            } else {
                XCTFail("Wrong NetworkError: \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}

private func assertNetworkError(
    _ expected: NetworkError,
    file: StaticString = #file,
    line: UInt = #line,
    operation: () async throws -> Void
) async {
    do {
        try await operation()
        XCTFail("Expected \(expected)", file: file, line: line)
    } catch let error as NetworkError {
        XCTAssertEqual(error, expected, file: file, line: line)
    } catch {
        XCTFail("Unexpected error type", file: file, line: line)
    }
}
