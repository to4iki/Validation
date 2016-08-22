import Foundation
import ListK

public protocol ValidationOps {}

extension ValidationOps where Self: Semigroup {

    public func success<T>() -> Validation<T, Self> {
        return .Success(self)
    }

    public func successNel<T>() -> Validation<NonEmptyList<T>, Self> {
        return success()
    }

    public func failure<T>() -> Validation<Self, T> {
        return .Failure(self)
    }

    public func failureNel<T>() -> Validation<NonEmptyList<Self>, T> {
        return .Failure(NonEmptyList(head: self, tail: .None))
    }
}

// MARK: - Int

extension Int: ValidationOps {}

// MARK: - String

extension String: ValidationOps {}

// MARK: - Array

extension Array: ValidationOps {}

// MARK: - List

extension List: ValidationOps {}

// MARK: - NonEmptyList

extension NonEmptyList: ValidationOps {}
