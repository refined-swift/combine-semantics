import Combine

/// The property of a publisher that meets the following rules:
///   - It cannot finish successfully without receiving a value.
///   - It cannot fail if it has already received a value.
///   - It cannot receive more than one value.
public protocol SingleValueSemantics {
    associatedtype Output
    associatedtype Failure: Swift.Error

    /// Wraps this publisher with a type eraser that preserves ``NonEmptySemantics`` and ``SingleValueSemantics` conformance.
    ///
    /// - Returns: An ``AnySingleValuePublisher`` wrapping this publisher.
    func eraseToAnySingleValuePublisher() -> AnySingleValuePublisher<Output, Failure>
}

/// A publisher that has the ``SingleValueSemantics`` property.
public typealias SingleValuePublisher = Publisher & SingleValueSemantics

extension SingleValueSemantics where Self: Publisher {
    public func eraseToAnySingleValuePublisher() -> AnySingleValuePublisher<Output, Failure> {
        AnySingleValuePublisher(self)
    }
}
