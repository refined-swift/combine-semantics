// Generated with gyb. Do not edit.

import Combine
@testable import CombineSemantics
import XCTest

final class CombineSemanticsTests: XCTestCase {
    struct SomeError: Swift.Error, Decodable {}

    var cancellable: Cancellable?

    var arrayInt: Publishers.Sequence<[Int], Never> { [1,1,2,3,1].publisher }
    var arrayData: Publishers.Sequence<[Data], Never> { ["{}".data(using: .utf8)!, "{}".data(using: .utf8)!].publisher }
    var emptyBool: Empty<Int, Never> { Empty<Int, Never>() }
    var emptyData: Empty<Data, Never> { Empty<Data, Never>() }
    var emptyFalible: Empty<Int, SomeError> { Empty<Int, SomeError>() }
    var emptyInt: Empty<Int, Never> { Empty<Int, Never>() }
    var emptyString: Empty<Int, Never> { Empty<Int, Never>() }
    var emptyVoid: Empty<Void, Never> { Empty<Void, Never>() }
    var failInt: Fail<Int, SomeError> { Fail(error: SomeError()) }
    var future1: Future<Int, Never> { Future({$0(.success(1))}) }
    var futureFail: Future<Int, SomeError> { Future({$0(.failure(SomeError()))}) }
    var just1: Just<Int> { Just(1) }
    var justData: Just<Data> { Just("{}".data(using: .utf8)!) }
    var justFalse: Just<Bool> { Just(false) }
    var justTrue: Just<Bool> { Just(true) }
    var justVoid: Just<Void> { Just(Void()) }
    var nilOptionalInt: Int? { nil }
    var nonEmptyInt: AnyNonEmptyPublisher<Int, Never> { Publishers.Concatenate(prefix: just1, suffix: just1 ).eraseToAnyNonEmptyPublisher() }

    func testDeferredSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = Deferred(createPublisher: { self.emptyInt })
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testDeferredSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Deferred(createPublisher: { self.nonEmptyInt })
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testDeferredSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Deferred(createPublisher: { self.justTrue })
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testEmptySendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = self.emptyVoid
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testFailFails() {
        let expectation = self.expectation(description: #function)
        var failed = false
        cancellable = self.failInt
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    XCTFail()
                case .failure:
                    failed = true
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(failed)
    }

    func testFutureSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = future1
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testFutureSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = future1
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testJustSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = just1
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testJustSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = just1
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testAllSatisfySendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.AllSatisfy(upstream: arrayInt, predicate: { _ in false })
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testAllSatisfySendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.AllSatisfy(upstream: emptyString, predicate: { _ in false })
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testAssertNoFailureSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = Publishers.AssertNoFailure(upstream: emptyInt, prefix: String(), file: #file, line: #line)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testAssertNoFailureSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.AssertNoFailure(upstream: nonEmptyInt, prefix: String(), file: #file, line: #line)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testAssertNoFailureSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.AssertNoFailure(upstream: just1, prefix: String(), file: #file, line: #line)
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testAssertNoFailureSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.AssertNoFailure(upstream: arrayInt, prefix: String(), file: #file, line: #line)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testAutoconnectSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.map { _ in return String() }.multicast { PassthroughSubject<String, Never>() }.autoconnect()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testAutoconnectSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.map { return String($0) }.multicast { PassthroughSubject<String, Never>() }.autoconnect()
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testAutoconnectSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = just1.map { return String($0) }.multicast { PassthroughSubject<String, Never>() }.autoconnect()
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testAutoconnectSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.map { return String($0) }.multicast { PassthroughSubject<String, Never>() }.autoconnect()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testBreakpointSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = Publishers.Breakpoint(upstream: emptyInt, receiveSubscription: nil, receiveOutput: nil, receiveCompletion: nil)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testBreakpointSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Breakpoint(upstream: nonEmptyInt, receiveSubscription: nil, receiveOutput: nil, receiveCompletion: nil)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testBreakpointSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Breakpoint(upstream: just1, receiveSubscription: nil, receiveOutput: nil, receiveCompletion: nil)
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testBreakpointSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Breakpoint(upstream: arrayInt, receiveSubscription: nil, receiveOutput: nil, receiveCompletion: nil)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testBufferSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.buffer(size: 10, prefetch: .keepFull, whenFull: .dropNewest)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testBufferSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.buffer(size: 10, prefetch: .keepFull, whenFull: .dropNewest)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testBufferSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = justTrue.buffer(size: 10, prefetch: .keepFull, whenFull: .dropNewest)
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testBufferSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.buffer(size: 10, prefetch: .keepFull, whenFull: .dropNewest)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testCatchSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = futureFail.catch { _ in Empty<Int, Never>() }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testCatchSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.catch { _ in self.just1 }
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testCatchSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = futureFail.catch { _ in self.just1 }
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testCatchSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = futureFail.catch { _ in self.arrayInt }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testCollectSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.collect()
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testCollectSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = emptyInt.collect()
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testCollectByCountSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.collect(1)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testCollectByCountSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.collect(2)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testCollectByCountSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = just1.collect(2)
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testCollectByCountSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.collect(3)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testCollectByTimeSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.collect(.byTimeOrCount(DispatchQueue(label: #function), 0, 1))
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0.1)
        XCTAssertTrue(finished)
    }

    func testCollectByTimeSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.collect(.byTimeOrCount(DispatchQueue(label: #function), 0, 1))
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0.1)
        XCTAssertGreaterThan(values, 0)
    }


    func testCollectByTimeSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = just1.collect(.byTimeOrCount(DispatchQueue(label: #function), 0, 1))
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0.1)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testCollectByTimeSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.collect(.byTimeOrCount(DispatchQueue(label: #function), 0, 1))
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0.1)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testCombineLatestSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = Publishers.CombineLatest(emptyInt, emptyVoid)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testCombineLatestSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.CombineLatest(nonEmptyInt, justFalse)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testCombineLatestSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.CombineLatest(justTrue, justFalse)
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testCombineLatestSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.CombineLatest(arrayInt, arrayInt)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testCombineLatest3SendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = Publishers.CombineLatest3(emptyInt, emptyVoid, emptyString)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testCombineLatest3SendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.CombineLatest3(nonEmptyInt, nonEmptyInt, nonEmptyInt)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testCombineLatest3SendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.CombineLatest3(justTrue, justFalse, justVoid)
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testCombineLatest3SendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.CombineLatest3(arrayInt, arrayInt, arrayInt)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testCombineLatest4SendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = Publishers.CombineLatest4(emptyInt, emptyVoid, emptyString, emptyBool)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testCombineLatest4SendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.CombineLatest4(nonEmptyInt, nonEmptyInt, nonEmptyInt, nonEmptyInt)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testCombineLatest4SendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.CombineLatest4(justTrue, justFalse, justVoid, just1)
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testCombineLatest4SendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.CombineLatest4(arrayInt, arrayInt, arrayInt, arrayInt)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testCompactMapSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = just1.compactMap { _ in nilOptionalInt }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testComparisonSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = Publishers.Comparison(upstream: emptyInt, areInIncreasingOrder: {  $0 < $1 })
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testComparisonSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Comparison(upstream: nonEmptyInt, areInIncreasingOrder: {  $0 < $1 })
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testComparisonSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Comparison(upstream: nonEmptyInt, areInIncreasingOrder: {  $0 < $1 })
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testConcatenateSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Concatenate(prefix: nonEmptyInt, suffix: nonEmptyInt)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testConcatenateSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Concatenate(prefix: justTrue, suffix: justFalse)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testContainsSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.contains(0)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testContainsSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = emptyInt.contains(0)
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testContainsWhereSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.contains(where: { _ in false })
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testContainsWhereSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = emptyInt.contains(where: { _ in false })
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testCountSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.count()
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testCountSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = emptyInt.count()
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testDebounceSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.debounce(for: 0, scheduler: ImmediateScheduler.shared)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testDecodeSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = Publishers.Decode(upstream: emptyData, decoder: JSONDecoder()).map { error -> SomeError in error }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testDecodeSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Decode(upstream: justData.eraseToAnyNonEmptyPublisher(), decoder: JSONDecoder()).map { error -> SomeError in error }
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testDecodeSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Decode(upstream: justData, decoder: JSONDecoder()).map { error -> SomeError in error }
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testDecodeSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Decode(upstream: arrayData, decoder: JSONDecoder()).map { error -> SomeError in error }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testDelaySendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = Publishers.Delay(upstream: emptyInt, interval: 0.0, tolerance: 0.0, scheduler: ImmediateScheduler.shared)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testDelaySendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Delay(upstream: just1, interval: 0.0, tolerance: 0.0, scheduler: ImmediateScheduler.shared)
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testDelaySendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Delay(upstream: nonEmptyInt, interval: 0.0, tolerance: 0.0, scheduler: ImmediateScheduler.shared)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testDelaySendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Delay(upstream: arrayInt, interval: 0.0, tolerance: 0.0, scheduler: ImmediateScheduler.shared)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testDropSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = Publishers.Drop(upstream: emptyInt, count: 1)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testDropSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Drop(upstream: arrayInt, count: 1)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testDropUntilOutputSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = Publishers.DropUntilOutput(upstream: emptyInt, other: just1)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testDropUntilOutputSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.DropUntilOutput(upstream: arrayInt, other: just1)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testDropWhileSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = Publishers.DropWhile(upstream: emptyInt, predicate: { _ in false })
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testDropWhileSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.DropWhile(upstream: arrayInt, predicate: { _ in false })
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testEncodeSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = Publishers.Encode(upstream: emptyInt, encoder: JSONEncoder())
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testEncodeSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Encode(upstream: nonEmptyInt, encoder: JSONEncoder())
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testEncodeSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Encode(upstream: just1, encoder: JSONEncoder())
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testEncodeSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Encode(upstream: arrayInt, encoder: JSONEncoder())
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testFilterSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.filter { _ in true }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testFilterSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.filter { _ in true }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testFirstSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyVoid.first()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testFirstSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.first()
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testFirstSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.first()
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testFirstWhereSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.first { _ in true }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testFlatMapSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.flatMap { _ in self.justTrue }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testFlatMapSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.flatMap { _ in self.justTrue }
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testFlatMapSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = just1.flatMap { _ in self.justTrue }
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testFlatMapSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.flatMap { _ in self.justTrue }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testHandleEventsSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.handleEvents()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testHandleEventsSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.handleEvents()
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testHandleEventsSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = just1.handleEvents()
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testHandleEventsSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.handleEvents()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testIgnoreOutputSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = Publishers.IgnoreOutput(upstream: arrayInt)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testLastSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.last()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testLastSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.last()
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testLastSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.last()
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testLastWhereSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.last { _ in true }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testMakeConnectableSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = nil; let connectable = Publishers.MakeConnectable(upstream: emptyInt); cancellable = connectable.connect(); _ = connectable
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testMakeConnectableSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nil; let connectable = Publishers.MakeConnectable(upstream: nonEmptyInt); cancellable = connectable.connect(); _ = connectable
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testMakeConnectableSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nil; let connectable = Publishers.MakeConnectable(upstream: just1); cancellable = connectable.connect(); _ = connectable
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testMakeConnectableSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nil; let connectable = Publishers.MakeConnectable(upstream: arrayInt); cancellable = connectable.connect(); _ = connectable
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testMapSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.map { _ in 1 }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testMapSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.map { _ in 1 }
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testMapSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = just1.map { _ in 1 }
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testMapSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.map { _ in 1 }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testMapErrorSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.mapError { _ in SomeError() }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testMapErrorSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.mapError { _ in SomeError() }
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testMapErrorSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = just1.mapError { _ in SomeError() }
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testMapErrorSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.mapError { _ in SomeError() }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testMapKeyPathSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.map(\.byteSwapped)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testMapKeyPathSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.map(\.byteSwapped)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testMapKeyPathSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = just1.map(\.byteSwapped)
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testMapKeyPathSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.map(\.byteSwapped)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testMapKeyPath2SendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.map(\.byteSwapped)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testMapKeyPath2SendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.map(\.byteSwapped)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testMapKeyPath2SendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = just1.map(\.byteSwapped)
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testMapKeyPath2SendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.map(\.byteSwapped)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testMapKeyPath3SendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.map(\.byteSwapped)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testMapKeyPath3SendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.map(\.byteSwapped)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testMapKeyPath3SendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = just1.map(\.byteSwapped)
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testMapKeyPath3SendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.map(\.byteSwapped)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testMeasureIntervalSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = Publishers.MeasureInterval(upstream: self.emptyInt, scheduler: ImmediateScheduler.shared)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testMeasureIntervalSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.MeasureInterval(upstream: self.nonEmptyInt, scheduler: ImmediateScheduler.shared)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testMeasureIntervalSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.MeasureInterval(upstream: self.just1, scheduler: ImmediateScheduler.shared)
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testMergeSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Merge(self.nonEmptyInt, self.nonEmptyInt)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testMergeSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Merge(self.justTrue, self.justFalse)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testMerge3SendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Merge3(self.nonEmptyInt, self.nonEmptyInt, self.nonEmptyInt)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testMerge3SendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Merge3(self.justTrue, self.justFalse, self.justTrue)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testMerge4SendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Merge4(self.nonEmptyInt, self.nonEmptyInt, self.nonEmptyInt, self.nonEmptyInt)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testMerge4SendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Merge4(self.justTrue, self.justFalse, self.justTrue, self.justFalse)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testMerge5SendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Merge5(self.nonEmptyInt, self.nonEmptyInt, self.nonEmptyInt, self.nonEmptyInt, self.nonEmptyInt)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testMerge5SendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Merge5(self.justTrue, self.justFalse, self.justTrue, self.justFalse, self.justTrue)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testMerge6SendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Merge6(self.nonEmptyInt, self.nonEmptyInt, self.nonEmptyInt, self.nonEmptyInt, self.nonEmptyInt, self.nonEmptyInt)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testMerge6SendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Merge6(self.justTrue, self.justFalse, self.justTrue, self.justFalse, self.justTrue, self.justFalse)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testMerge7SendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Merge7(self.nonEmptyInt, self.nonEmptyInt, self.nonEmptyInt, self.nonEmptyInt, self.nonEmptyInt, self.nonEmptyInt, self.nonEmptyInt)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testMerge7SendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Merge7(self.justTrue, self.justFalse, self.justTrue, self.justFalse, self.justTrue, self.justFalse, self.justTrue)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testMerge8SendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Merge8(self.nonEmptyInt, self.nonEmptyInt, self.nonEmptyInt, self.nonEmptyInt, self.nonEmptyInt, self.nonEmptyInt, self.nonEmptyInt, self.nonEmptyInt)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testMerge8SendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Merge8(self.justTrue, self.justFalse, self.justTrue, self.justFalse, self.justTrue, self.justFalse, self.justTrue, self.justFalse)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testMergeManySendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = Publishers.MergeMany(emptyInt, emptyInt)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testMergeManySendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.MergeMany(nonEmptyInt, nonEmptyInt)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testMergeManySendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.merge(with: arrayInt)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testMulticastSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = nil; let multicast = emptyInt.multicast { PassthroughSubject<Int, Never>() }; cancellable = multicast
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        _ = multicast.connect()
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testMulticastSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nil; let multicast = nonEmptyInt.multicast { PassthroughSubject<Int, Never>() }; cancellable = multicast
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        _ = multicast.connect()
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testMulticastSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nil; let multicast = just1.multicast { PassthroughSubject<Int, Never>() }; cancellable = multicast
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        _ = multicast.connect()
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testMulticastSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nil; let multicast = arrayInt.multicast { PassthroughSubject<Int, Never>() }; cancellable = multicast
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        _ = multicast.connect()
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testOutputSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = Publishers.Output(upstream: emptyInt, range: 0..<3)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testOutputSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Output(upstream: arrayInt, range: 0..<3)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testPrefixUntilOutputSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.prefix(untilOutputFrom: emptyInt)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testPrefixWhileSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.prefix(while: { $0.isMultiple(of: 1) })
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testPrefixWhileSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.prefix(while: { $0.isMultiple(of: 1) })
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testPrintSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.print()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testPrintSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.print()
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testPrintSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = just1.print()
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testPrintSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.print()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testReceiveOnSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.receive(on: ImmediateScheduler.shared)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testReceiveOnSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.receive(on: ImmediateScheduler.shared)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testReceiveOnSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = just1.receive(on: ImmediateScheduler.shared)
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testReceiveOnSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.receive(on: ImmediateScheduler.shared)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testReduceSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.reduce(-1) { result, current in result + current }
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testReduceSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = emptyInt.reduce(-1) { result, current in result + current }
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testRemoveDuplicatesSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.removeDuplicates(by: { _, _ in false })
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testRemoveDuplicatesSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.removeDuplicates(by: { _, _ in true })
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testRemoveDuplicatesSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = just1.removeDuplicates(by: { _, _ in true })
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testRemoveDuplicatesSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.removeDuplicates(by: { _, _ in false })
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testReplaceEmptySendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = emptyInt.replaceEmpty(with: 1)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testReplaceEmptySendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = just1.replaceEmpty(with: 1)
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testReplaceEmptySendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.replaceEmpty(with: 1)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testReplaceErrorSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = just1.replaceError(with: 1)
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testReplaceErrorSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.replaceError(with: 1)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testReplaceErrorSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.replaceError(with: 1)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testRetrySendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.retry(1)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testRetrySendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.retry(1)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testRetrySendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = just1.retry(1)
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testRetrySendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.retry(1)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testScanSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.scan(-1) { previous, current in previous*current }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testScanSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.scan(-1) { previous, current in previous*current }
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testScanSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = just1.scan(-1) { previous, current in previous*current }
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testScanSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.scan(-1) { previous, current in previous*current }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testSequenceSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = Publishers.Sequence<[String], Never>(sequence: [])
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testSequenceSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Sequence<[Int], SomeError>(sequence: [1, 2])
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testSetFailureTypeSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.setFailureType(to: SomeError.self)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testSetFailureTypeSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.setFailureType(to: SomeError.self)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testSetFailureTypeSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = just1.setFailureType(to: SomeError.self)
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testSetFailureTypeSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.setFailureType(to: SomeError.self)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testShareSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = Publishers.Share(upstream: emptyInt)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testShareSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Share(upstream: nonEmptyInt)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testShareSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Share(upstream: just1)
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testShareSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Share(upstream: arrayInt)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testSubscribeOnSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.subscribe(on: ImmediateScheduler.shared)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testSubscribeOnSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.subscribe(on: ImmediateScheduler.shared)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testSubscribeOnSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = just1.subscribe(on: ImmediateScheduler.shared)
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testSubscribeOnSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.subscribe(on: ImmediateScheduler.shared)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testSwitchToLatestSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = Publishers.SwitchToLatest(upstream: Just(emptyInt))
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testSwitchToLatestSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.SwitchToLatest(upstream: Just(nonEmptyInt))
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testSwitchToLatestSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.SwitchToLatest(upstream: Just(just1))
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testSwitchToLatestSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.SwitchToLatest(upstream: [self.justTrue, self.justFalse].publisher)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testThrottleSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.throttle(for: 0, scheduler: ImmediateScheduler.shared, latest: false)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testThrottleSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.throttle(for: 0, scheduler: ImmediateScheduler.shared, latest: false)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testThrottleSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = just1.throttle(for: 0, scheduler: ImmediateScheduler.shared, latest: false)
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testThrottleSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.throttle(for: 0, scheduler: ImmediateScheduler.shared, latest: false)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testTryAllSatisfySendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.TryAllSatisfy(upstream: arrayInt, predicate: { _ in false })
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testTryAllSatisfySendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.TryAllSatisfy(upstream: emptyBool, predicate: { _ in false })
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testTryCatchSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = futureFail.tryCatch { _ in Empty<Int, Never>() }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testTryCatchSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = futureFail.tryCatch { _ in self.nonEmptyInt }
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testTryCatchSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = futureFail.tryCatch { _ in self.just1 }
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testTryCatchSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = futureFail.tryCatch { _ in self.arrayInt }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testTryCompactMapSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = just1.tryCompactMap { _ in self.nilOptionalInt }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testTryCompactMapSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.tryCompactMap { _ in self.just1 }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testTryComparisonSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = Publishers.TryComparison(upstream: emptyInt, areInIncreasingOrder: {  $0 < $1 })
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testTryComparisonSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.TryComparison(upstream: nonEmptyInt, areInIncreasingOrder: {  $0 < $1 })
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testTryComparisonSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.TryComparison(upstream: nonEmptyInt, areInIncreasingOrder: {  $0 < $1 })
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testTryContainsWhereSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.tryContains(where: { _ in false })
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testTryContainsWhereSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = emptyInt.tryContains(where: { _ in false })
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testTryDropWhileSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = Publishers.TryDropWhile(upstream: emptyInt, predicate: { _ in false })
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testTryDropWhileSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.TryDropWhile(upstream: arrayInt, predicate: { _ in false })
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testTryFilterSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.tryFilter { _ in true }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testTryFilterSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.tryFilter { _ in true }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testTryFirstWhereSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.tryFirst { _ in true }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testTryLastWhereSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.tryLast { _ in true }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testTryMapSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.tryMap { _ in 1 }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testTryMapSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.tryMap { _ in 1 }
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testTryMapSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = just1.tryMap { _ in 1 }
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testTryMapSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.tryMap { _ in 1 }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testTryPrefixWhileSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.tryPrefix(while: { $0.isMultiple(of: 1) })
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testTryPrefixWhileSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.tryPrefix(while: { $0.isMultiple(of: 1) })
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testTryReduceSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.tryReduce(-1) { result, current in result + current }
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testTryReduceSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = emptyInt.tryReduce(-1) { result, current in result + current }
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testTryRemoveDuplicatesSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.tryRemoveDuplicates(by: { _, _ in false })
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testTryRemoveDuplicatesSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.tryRemoveDuplicates(by: { _, _ in true })
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testTryRemoveDuplicatesSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = just1.tryRemoveDuplicates(by: { _, _ in true })
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testTryRemoveDuplicatesSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.tryRemoveDuplicates(by: { _, _ in false })
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testTryScanSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = emptyInt.tryScan(-1) { previous, current in previous*current }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testTryScanSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = nonEmptyInt.tryScan(-1) { previous, current in previous*current }
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testTryScanSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = just1.tryScan(-1) { previous, current in previous*current }
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testTryScanSendsMultipleValues() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = arrayInt.tryScan(-1) { previous, current in previous*current }
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertGreaterThan(values, 1)
    }

    func testZipSendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = Publishers.Zip(emptyBool, Empty<String, Never>())
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testZipSendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Zip(nonEmptyInt, just1)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testZipSendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Zip(future1, just1)
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testZip3SendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = Publishers.Zip3(emptyInt, emptyString, emptyBool)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testZip3SendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Zip3(nonEmptyInt, nonEmptyInt, nonEmptyInt)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testZip3SendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Zip3(future1, just1, justVoid)
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }

    func testZip4SendsNoValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        cancellable = Publishers.Zip4(emptyInt, emptyString, emptyBool, emptyVoid)
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
    }

    func testZip4SendsSomeValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Zip4(nonEmptyInt, nonEmptyInt, nonEmptyInt, nonEmptyInt)
            .eraseToAnyNonEmptyPublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                if values == 0 {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                values += 1
                if values == 1 && !finished {
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(values, 0)
    }


    func testZip4SendsSingleValue() {
        let expectation = self.expectation(description: #function)
        var finished = false
        var values = 0
        cancellable = Publishers.Zip4(future1, just1, justVoid, justTrue)
            .eraseToAnySingleValuePublisher()
            .sink { result in
                switch result {
                case .finished:
                    finished = true
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { value in
                values += 1
            }
        
        wait(for: [expectation], timeout: 0)
        XCTAssertTrue(finished)
        XCTAssertEqual(values, 1)
    }
}
