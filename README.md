# combine-semantics 

This repository includes sample implementation of a partially type-erased publisher that retains significant properties from its upstream publisher.

## Motivation

Exposing type-erased publishers across APIs boundaries ensures that changing the underlying implementations won't affect existing code using such APIs. It is also useful to prevent callers from accessing certain methods from the wrapped types (see `Subject` example provided in `AnyPublisher` [documentation](https://developer.apple.com/documentation/combine/anypublisher)).

But along with those undesired type details, type erasure -as implemented by `AnyPublisher`- also discards any intrinsic semantics carried by the concrete publisher type being wrapped; including properties that could help API consumers to reason about their code and play a role in its (compile-time) type safety.

As a side note, if you are not familiar with *type-rich programming* you can watch Bjarne Stroustrup [talk](https://youtu.be/0iWb_qi2-uI?t=19m6s) on the topic (I found it via this [SO answer](https://stackoverflow.com/a/39417034)).

## Proposed solution

The **CombineSemantics** library demonstrates how to model meaningful publisher properties into Swift protocols. Concrete publishers can declare their compliance to the semantics associated with a protocol by conforming to it.

## Detailed design

The sample implementation focuses only on *single value* publishers. This property, modeled by the `SingleValueSemantics` protocol, defines a publisher that cannot:

- finish successfully without receiving a value
- fail if it has already received a value
- receive more than one value

In order to make conditional conformance to `SingleValueSemantics` more fine-grained, another protocol is declared, `NonEmptySemantics` that models *non-empty* publishers

The codebase is structured in the following folders:

* `Sources/CombineSemantics`
* `Tests/CombineSemantics`
* `resources`
* `scripts`

#### Sources/CombineSemantics

It contains the new publisher protocols:
- `NonEmptySemantics`
- `SingleValueSemantics`

And their corresponding type-erased concrete implementations:
- `AnyNonEmptyPublisher`
- `AnySingleValuePublisher`.

Lastly, there are extensions for **Combine**'s publishers to conditionally conform the aforementioned protocols. 

#### Tests/CombineSemantics

It contains both the [gyb](https://github.com/apple/swift/blob/main/utils/gyb.py) template and the generated test case where partially type-erased publishers behavior is checked.

#### resources

It contains the [csv](https://wikipedia.org/wiki/Comma-separated_values) representation of the tests (it is required from the [gyb](https://github.com/apple/swift/blob/main/utils/gyb.py) template).

#### scripts

It contains the shell scripts used to download and execute [gyb](https://github.com/apple/swift/blob/main/utils/gyb.py):

- use `scripts/download_gyb.sh` to download a local copy of [gyb](https://github.com/apple/swift/blob/main/utils/gyb.py)
- use `scripts/process_gyb.sh Tests/CombineSemanticsTests/` to regenerate the tests
