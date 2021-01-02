import Combine

/// The property of a publisher that meets the following rule:
///   - It cannot finish successfully without receiving a value.
public protocol NonEmptySemantics {
    associatedtype Output
    associatedtype Failure: Swift.Error

    /// Wraps this publisher with a type eraser that preserves ``NonEmptySemantics`` conformance.
    ///
    /// - Returns: An ``AnySingleValuePublisher`` wrapping this publisher.
    func eraseToAnyNonEmptyPublisher() -> AnyNonEmptyPublisher<Output, Failure>
}

/// A publisher that has the ``NonEmptySemantics`` property.
public typealias NonEmptyPublisher = Publisher & NonEmptySemantics

extension NonEmptySemantics where Self: Publisher {
    public func eraseToAnyNonEmptyPublisher() -> AnyNonEmptyPublisher<Output, Failure> {
        AnyNonEmptyPublisher(self)
    }
}
