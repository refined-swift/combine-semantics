import Combine

/// A publisher that performs type erasure by wrapping another publisher in a similar way to ``AnyPublisher``, but preserving ``NonEmptySemantics`` and ``SingleValueSemantics`` properties.
public struct AnySingleValuePublisher<Output, Failure: Swift.Error>: Publisher, NonEmptySemantics, SingleValueSemantics {
    private let underlyingPublisher: AnyPublisher<Output, Failure>

    public func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        underlyingPublisher.receive(subscriber: subscriber)
    }

    public init<P: Publisher & SingleValueSemantics>(_ publisher: P) where Output == P.Output, Failure == P.Failure {
        underlyingPublisher = AnyPublisher(publisher)
    }
}
