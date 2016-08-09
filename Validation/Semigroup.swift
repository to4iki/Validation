import Foundation
import ListK

public protocol Semigroup {

    func append(other: Self) -> Self
}

// MARK: - Int

extension Int: Semigroup {

    public func append(other: Int) -> Int {
        return self + other
    }
}

// MARK: - String

extension String: Semigroup {

    public func append(other: String) -> String {
        return self + "," + other
    }
}

// MARK: - Array

extension Array: Semigroup {

    public func append(other: [Element]) -> [Element] {
        return self + other
    }
}

// MARK: - List

extension List: Semigroup {

    public func append(other: List<Element>) -> List<Element> {
        return self + other
    }
}

// MARK: - NonEmptyList

extension NonEmptyList: Semigroup {

    public func append(other: NonEmptyList<Element>) -> NonEmptyList<Element> {
        return NonEmptyList(head: self.head, tail: self.tail + other.toList())
    }
}
